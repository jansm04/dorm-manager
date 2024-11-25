window.onload = function() {
	document.getElementById("AddDataButton").addEventListener("click", handleClickAdd);
	document.getElementById("ShowButton").addEventListener("click", tableCreate);
	document.getElementById("RegularDropdown").addEventListener("mouseover", loadDropdown);
	document.getElementById("earliestDeliveriesButton").addEventListener("click", fetchEarliestDeliveries);
	document.getElementById("buildingCountsButton").addEventListener("click", fetchBuildingCounts);
	document.getElementById("buildingsSqftButton").addEventListener("click", fetchBuildingSqfts);
	selectDropdownCreate();
};

function handleClickAdd() {
	window.open('AddData.html');
}

function handleClickDropdown(evt) {
	alert("you just clicked "+ evt.currentTarget.id)
}

function tableCreate() {
	let tbl = document.getElementById("table");
	while (tbl.rows.length > 0) {
		tbl.deleteRow(0);
	}

	let tr = tbl.insertRow();
	tableAddElement(tr, "tableTitle", "location");
	tableAddElement(tr, "tableTitle", "size");
	tableAddElement(tr, "tableTitle", "some other thing");
	tr = tbl.insertRow();
	tableAddElement(tr, "tableElement", "Marine");
	tableAddElement(tr, "tableElement", "444");
	tableAddElement(tr, "tableElement", "idk");
	tr = tbl.insertRow();
	tableAddElement(tr, "tableElement", "Gage");
	tableAddElement(tr, "tableElement", "360");
	tableAddElement(tr, "tableElement", "bro no idea");
	tr = tbl.insertRow();
	tableAddElement(tr, "tableElement", "Exchange");
	tableAddElement(tr, "tableElement", "700");
	tableAddElement(tr, "tableElement", "what even");
}

function tableAddElement(tr, classText, content) {
	const td = tr.insertCell();
	td.className = classText;
	td.appendChild(document.createTextNode(content));
}

function loadDropdown(){
	document.getElementById("dropdownContents").innerHTML = "";
	dropdownAddElement("option 1");
	dropdownAddElement("option 2");
	dropdownAddElement("option 3");
}

function dropdownAddElement(content) {
	var a = document.createElement('a');
	a.id = content;
	var linkText = document.createTextNode(content);
	a.addEventListener("click", handleClickDropdown);
	a.appendChild(linkText);
	document.getElementById("dropdownContents").appendChild(a);
}


function selectDropdownCreate(){
	selectDropdownAddElement("option 1");
	selectDropdownAddElement("option 2");
	selectDropdownAddElement("option 3");
}

function selectDropdownAddElement(content) {
	const c = document.createElement("INPUT");
	c.setAttribute("type", "checkbox");
	c.id = "checkbox_"+content;
	document.getElementById("SelectionDropdownContents").appendChild(c);
	const a = document.createElement("label");
	a.innerHTML = " " + content;
	document.getElementById("SelectionDropdownContents").appendChild(a);
	const br = document.createElement("br");
	document.getElementById("SelectionDropdownContents").appendChild(br);
}

function formatDate(created_at) {
	const date = new Date(created_at);
	return new Intl.DateTimeFormat('en-US', {
		month: 'long',
		day: 'numeric',
		year: 'numeric'
	}).format(date);
}

// Fetches each resident's earliest package delivery
async function fetchEarliestDeliveries(event) {
    event.preventDefault();

	try {
		const response = await fetch("/earliest-deliveries", {
			method: 'GET'
		});
		const responseData = await response.json();
    	const tableContent = responseData.data;

		const tableElement = document.getElementById("earliestDeliveriesTable");
		const tableHeader = tableElement.querySelector('thead');
		tableHeader.innerHTML = ''; // clear

		const tr = tableHeader.insertRow();
		tableAddElement(tr, "tableTitle", "Resident ID");
		tableAddElement(tr, "tableTitle", "Resident Name");
		tableAddElement(tr, "tableTitle", "Earliest Delivery");

		const tableBody = tableElement.querySelector('tbody');
		tableBody.innerHTML = ''; // clear
	
		const dateIndex = 2;
		tableContent.forEach(record => {
			const tr = tableBody.insertRow();
			record.forEach((field, index) => {
				tableAddElement(tr, "tableElement", index === dateIndex ? formatDate(field) : field);
			});
		});
	} catch (error) {
		console.error(error);
	}
}

// Fetches the number of residents in each building
async function fetchBuildingCounts(event) {
    event.preventDefault();

	try {
		const minValue = document.getElementById('buildingsCountTextInput').value;
		const response = await fetch('/building-counts', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				min: Number(minValue)
			})
		});

		const responseData = await response.json();
		const tableContent = responseData.data;

		const tableElement = document.getElementById("buildingCountsTable");
		const tableHeader = tableElement.querySelector('thead');
		tableHeader.innerHTML = ''; // clear

		const tr = tableHeader.insertRow();
		tableAddElement(tr, "tableTitle", "Building");
		tableAddElement(tr, "tableTitle", "Number of Residents");

		const tableBody = tableElement.querySelector('tbody');
		tableBody.innerHTML = ''; // clear
	
		tableContent.forEach(record => {
			const tr = tableBody.insertRow();
			record.forEach((field, index) => {
				tableAddElement(tr, "tableElement", field);
			});
		});
	} catch (error) {
		console.error(error);
	}
}


// Fetches the average sqft of a room in each building
async function fetchBuildingSqfts(event) {
    event.preventDefault();

	try {
		const response = await fetch("/building-sqfts", {
			method: 'GET'
		});
		const responseData = await response.json();
    	const tableContent = responseData.data;

		const tableElement = document.getElementById("buildingsSqftTable");
		const tableHeader = tableElement.querySelector('thead');
		tableHeader.innerHTML = ''; // clear

		const tr = tableHeader.insertRow();
		tableAddElement(tr, "tableTitle", "Building");
		tableAddElement(tr, "tableTitle", "Average Room Sqft");
		
		const tableBody = tableElement.querySelector('tbody');
		tableBody.innerHTML = ''; // clear
	
		tableContent.forEach(record => {
			const tr = tableBody.insertRow();
			record.forEach((field, index) => {
				tableAddElement(tr, "tableElement", field);
			});
		});
	} catch (error) {
		console.error(error);
	}
}





