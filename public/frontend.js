window.onload = function() {
	document.getElementById("AddDataButton").addEventListener("click", handleClickAdd);
	document.getElementById("ShowButton").addEventListener("click", tableCreate);
	document.getElementById("RegularDropdown").addEventListener("mouseover", loadDropdown);
	document.getElementById("earliestDeliveriesButton").addEventListener("click", fetchEarliestDeliveries);
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







