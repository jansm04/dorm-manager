const oracledb = require('oracledb');
const loadEnvFile = require('./utils/envUtil');
//require('dotenv').config();
const envVariables = loadEnvFile('./.env');

// Database configuration setup. Ensure your .env file has the required database credentials.
const dbConfig = {
    //user: process.env.ORACLE_USER,
    //password: process.env.ORACLE_PASS,
    //connectString: `${process.env.ORACLE_HOST}:${process.env.ORACLE_PORT}/${process.env.ORACLE_DBNAME}`,
    user: envVariables.ORACLE_USER,
    password: envVariables.ORACLE_PASS,
    connectString: `${envVariables.ORACLE_HOST}:${envVariables.ORACLE_PORT}/${envVariables.ORACLE_DBNAME}`,
    poolMin: 1,
    poolMax: 3,
    poolIncrement: 1,
    poolTimeout: 60
};


// initialize connection pool
async function initializeConnectionPool() {
    try {
        oracledb.initOracleClient({ libDir: process.env.ORACLE_DIR })
        await oracledb.createPool(dbConfig);
        console.log('Connection pool started');
    } catch (err) {
        console.error('Initialization error: ' + err.message);
    }
}

async function closePoolAndExit() {
    console.log('\nTerminating');
    try {
        await oracledb.getPool().close(10); // 10 seconds grace period for connections to finish
        console.log('Pool closed');
        process.exit(0);
    } catch (err) {
        console.error(err.message);
        process.exit(1);
    }
}

initializeConnectionPool();

process
    .once('SIGTERM', closePoolAndExit)
    .once('SIGINT', closePoolAndExit);


// ----------------------------------------------------------
// Wrapper to manage OracleDB actions, simplifying connection handling.
async function withOracleDB(action) {
    let connection;
    try {
        connection = await oracledb.getConnection(); // Gets a connection from the default pool 
        return await action(connection);
    } catch (err) {
        console.error(err);
        throw err;
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
}


// ----------------------------------------------------------
// Core functions for database operations
// Modify these functions, especially the SQL queries, based on your project's requirements and design.
async function testOracleConnection() {
    return await withOracleDB(async (connection) => {
        return true;
    }).catch(() => {
        return false;
    });
}

async function fetchDemotableFromDb() {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute('SELECT * FROM DEMOTABLE');
        return result.rows;
    }).catch(() => {
        return [];
    });
}

async function initiateDemotable() {
    return await withOracleDB(async (connection) => {
        try {
            await connection.execute(`DROP TABLE DEMOTABLE`);
        } catch(err) {
            console.log('Table might not exist, proceeding to create...');
        }

        const result = await connection.execute(`
            CREATE TABLE DEMOTABLE (
                id NUMBER PRIMARY KEY,
                name VARCHAR2(20)
            )
        `);
        return true;
    }).catch(() => {
        return false;
    });
}

async function insertDemotable(id, name) {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute(
            `INSERT INTO DEMOTABLE (id, name) VALUES (:id, :name)`,
            [id, name],
            { autoCommit: true }
        );

        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}

async function updateNameDemotable(oldName, newName) {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute(
            `UPDATE DEMOTABLE SET name=:newName where name=:oldName`,
            [newName, oldName],
            { autoCommit: true }
        );

        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}

async function countDemotable() {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute('SELECT Count(*) FROM DEMOTABLE');
        return result.rows[0][0];
    }).catch(() => {
        return -1;
    });
}

/**
 * Fetches the earliest date a package was delivered for every resident with at least one
 * package delivery. Joins with PermanentResident to return the resident names in addition
 * to the resident IDs.
 * 
 * @returns the rows from the query result
 */
async function fetchEarliestDeliveries() {
    return await withOracleDB(async (connection) => {
        const query = `
            SELECT p.studentId, p.name, d.earliest_delivery
            FROM (  
                SELECT studentId, min(deliveryDate) as earliest_delivery
                FROM Package
                GROUP BY studentId
            ) d
            JOIN PermanentResident p
            ON d.studentId = p.studentId
        `;
        const result = await connection.execute(query);
        return result.rows;
    }).catch(() => {
        return false;
    });
}

/**
 * Fetches the number of residents in each building. Filters out all the buildings where the number
 * of residents is less than the given requirement.
 * 
 * @param {*} min the minimum count to filter out all the buildings with less than min residents
 * @returns the rows from the query result
 */
async function fetchBuildingCounts(min) {
    return await withOracleDB(async (connection) => {
        const query = `
            SELECT buildingName, COUNT(*)
            FROM PermanentResident
            GROUP BY buildingName
            HAVING COUNT(*) >= :min
        `;
        const result = await connection.execute(query, [min]);
        return result.rows;
    }).catch(() => {
        return false;
    });
}

/**
 * Fetches the average room square footage in each building. Filters out all the buildings where 
 * the average room sqft is less than the average room sqft in all buildings.
 * 
 * @returns the rows from the query result
 */
async function fetchBuildingSqfts() {
    return await withOracleDB(async (connection) => {
        const query = `
            SELECT buildingName, avg(sqfeet)
                FROM Room_R2
                GROUP BY buildingName
                HAVING avg(sqfeet) >= (SELECT avg(sqfeet)
                                        FROM Room_R2)
        `;
        const result = await connection.execute(query);
        return result.rows;
    }).catch(() => {
        return false;
    })
}

/**
 * Fetches the information of a resident by ID
 * @returns the rows from the query result
 */
async function fetchResident(id) {
    return await withOracleDB(async (connection) => {
        const query = `
            SELECT studentId, age, name, email, roomNumber, unitNumber, buildingName
            FROM PermanentResident
            WHERE studentId = :id`
        ;
        const result = await connection.execute(query, [id]);
        return result.rows;
    }).catch(() => {
        return false;
    });
}


/**
 * creates the information of a resident into PermanentResident
 * @returns the rows from the query result
 */
async function createResident(data) {
    id = Number(data[0]);
    nm = data[1];
    email = data[2];
    age = Number(data[3]);
    room = Number(data[4]);
    unit = Number(data[5]);
    bld = data[6];
    return await withOracleDB(async (connection) => {
        const query = `
            INSERT INTO PermanentResident (studentId, roomNumber, unitNumber, buildingName, age, name, email) 
            VALUES (:id, :room, :unit, :bld, :age, :nm, :email)`
        ;
        const result = await connection.execute(query,[id, room, unit, bld, age, nm, email],{ autoCommit: true });
        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}

/**
 * deletes the information of a resident by ID
 * @returns the rows from the query result
 */
async function editResident(data) {
    id = Number(data[0]);
    field = data[1];
    if(field === "room" || field === "unit" || field === "age"){
        valnum = Number(data[2]);
        return await withOracleDB(async (connection) => {
            const query = `UPDATE PermanentResident
            SET :field=:valnum
            WHERE studentId=:id`;
            const result = await connection.execute(query,[id, field, valnum],{ autoCommit: true });
        console.error("hoping");

            return result.rowsAffected && result.rowsAffected > 0;
        }).catch(() => {
            return false;
        });
    } else {
        valstring = String(data[2]);
        return await withOracleDB(async (connection) => {
            const query = `UPDATE PermanentResident SET email = :valstring WHERE studentId= :id`;
            const result = await connection.execute(query,[id, valstring],{ autoCommit: true });
            return result.rowsAffected && result.rowsAffected > 0;
        }).catch(() => {
            return false;
        });
    }
    
    
}

async function deleteResident(id) {
    return await withOracleDB(async (connection) => {
        const query = `DELETE FROM PermanentResident WHERE studentId=:id`;
        const result = await connection.execute(query,[id],{ autoCommit: true });
        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}

async function fetchResidentTable() {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute('SELECT * FROM PermanentResident');
        return result.rows;
    }).catch(() => {
        return [];
    });
}

module.exports = {
    testOracleConnection,
    fetchDemotableFromDb,
    initiateDemotable, 
    insertDemotable, 
    updateNameDemotable, 
    countDemotable,
    fetchEarliestDeliveries,
    fetchBuildingCounts,
    fetchBuildingSqfts,
    fetchResident,
    createResident,
    editResident,
    deleteResident,
    fetchResidentTable
};