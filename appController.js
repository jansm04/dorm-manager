const express = require('express');
const appService = require('./appService');

const router = express.Router();

// ----------------------------------------------------------
// API endpoints
// Modify or extend these routes based on your project's needs.
router.get('/check-db-connection', async (req, res) => {
    const isConnect = await appService.testOracleConnection();
    if (isConnect) {
        res.send('connected');
    } else {
        res.send('unable to connect');
    }
});

router.get('/demotable', async (req, res) => {
    const tableContent = await appService.fetchDemotableFromDb();
    res.json({data: tableContent});
});

router.post("/initiate-demotable", async (req, res) => {
    const initiateResult = await appService.initiateDemotable();
    if (initiateResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

router.post("/insert-demotable", async (req, res) => {
    const { id, name } = req.body;
    const insertResult = await appService.insertDemotable(id, name);
    if (insertResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

router.post("/update-name-demotable", async (req, res) => {
    const { oldName, newName } = req.body;
    const updateResult = await appService.updateNameDemotable(oldName, newName);
    if (updateResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

router.get('/count-demotable', async (req, res) => {
    const tableCount = await appService.countDemotable();
    if (tableCount >= 0) {
        res.json({ 
            success: true,  
            count: tableCount
        });
    } else {
        res.status(500).json({ 
            success: false, 
            count: tableCount
        });
    }
});

router.get('/earliest-deliveries', async (req, res) => {
    const tableContent = await appService.fetchEarliestDeliveries();
    if (!tableContent) {
        res.status(500).json({ success: false });
    } else {
        res.json({ data: tableContent });
    }
})

router.post('/building-counts', async (req, res) => {
    const { min } = req.body;
    const tableContent = await appService.fetchBuildingCounts(min);
    if (!tableContent) {
        res.status(500).json({ success: false });
    } else {
        res.json({ data: tableContent });
    }
})

router.get('/building-sqfts', async (req, res) => {
    const tableContent = await appService.fetchBuildingSqfts();
    if (!tableContent) {
        res.status(500).json({ success: false });
    } else {
        res.json({ data: tableContent });
    } 
})

router.get('/ra-id', async (req, res) => {
    const tableContent = await appService.fetchRAId(req.query.id);
    if (!tableContent) {
        res.status(500).json({ success: false });
    } else {
        res.json({ data: tableContent });
    } 
})

router.get('/tenancy', async (req, res) => {
    const tableContent = await appService.fetchTenancyInformation(req.query.id);
    if (!tableContent) {
        res.status(500).json({ success: false });
    } else {
        res.json({ data: tableContent });
    }
})

router.get('/building-with-all-rooms', async (req, res) => {
    const tableContent = await appService.fetchBuildingWithAllRooms();
    if (!tableContent) {
        res.status(500).json({ success: false });
    } else {
        res.json({ data: tableContent });
    }
})


module.exports = router;