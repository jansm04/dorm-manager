document.getElementById("AddButton").addEventListener("click", handleClickAdd);
document.getElementById("EditButton").addEventListener("click", handleClickEdit);
document.getElementById("DeleteButton").addEventListener("click", handleClickRemove);
document.getElementById("SelectButton").addEventListener("click", handleClickSelect);
document.getElementById("AddSendButton").addEventListener("click", handleAddSend);
document.getElementById("EditSendButton").addEventListener("click", handleEditSend);
document.getElementById("DeleteSendButton").addEventListener("click", handleDeleteSend);
document.getElementById("SelectSendButton").addEventListener("click", handleSelectSend);
document.getElementById("name").addEventListener("click", handleSelectField);
document.getElementById("email").addEventListener("click", handleSelectField);
document.getElementById("age").addEventListener("click", handleSelectField);
document.getElementById("room").addEventListener("click", handleSelectField);
document.getElementById("unit").addEventListener("click", handleSelectField);
document.getElementById("building").addEventListener("click", handleSelectField);
handleClickAdd();

function handleClickAdd() {
	document.getElementById("AddButton").style.background='#464958';
	document.getElementById("EditButton").style.background='#252c57';
	document.getElementById("DeleteButton").style.background='#252c57';
	document.getElementById("SelectButton").style.background='#252c57';
	document.getElementById("AddDiv").style.display = "block";
	document.getElementById("EditDiv").style.display = "none";
	document.getElementById("RemoveDiv").style.display = "none";
	document.getElementById("SelectDiv").style.display = "none";
}

function handleClickEdit() {
	document.getElementById("AddButton").style.background='#252c57';
	document.getElementById("EditButton").style.background='#464958';
	document.getElementById("DeleteButton").style.background='#252c57';
	document.getElementById("SelectButton").style.background='#252c57';
	document.getElementById("AddDiv").style.display = "none";
	document.getElementById("EditDiv").style.display = "block";
	document.getElementById("RemoveDiv").style.display = "none";
	document.getElementById("SelectDiv").style.display = "none";
	document.getElementById("newValueDescriptor").style.display = "none";
	document.getElementById("EditTextInput").style.display = "none";
	document.getElementById("EditTimeInput").style.display = "none";
	document.getElementById("EditfieldsContainer").style.display = "none";
	document.getElementById("EditBuildingFieldCreator").style.display = "none";
	document.getElementById("EditSendButton").style.display = "none";
}

function handleClickRemove() {
	document.getElementById("AddButton").style.background='#252c57';
	document.getElementById("EditButton").style.background='#252c57';
	document.getElementById("DeleteButton").style.background='#464958';
	document.getElementById("SelectButton").style.background='#252c57';
	document.getElementById("AddDiv").style.display = "none";
	document.getElementById("EditDiv").style.display = "none";
	document.getElementById("RemoveDiv").style.display = "block";
	document.getElementById("SelectDiv").style.display = "none";
}

function handleClickSelect() {
	document.getElementById("AddButton").style.background='#252c57';
	document.getElementById("EditButton").style.background='#252c57';
	document.getElementById("DeleteButton").style.background='#252c57';
	document.getElementById("SelectButton").style.background='#464958';
	document.getElementById("AddDiv").style.display = "none";
	document.getElementById("EditDiv").style.display = "none";
	document.getElementById("RemoveDiv").style.display = "none";
	document.getElementById("SelectDiv").style.display = "block";
}


function handleAddSend() {
	var id = document.getElementById("AddIDInput").value;
	var name = document.getElementById("AddNameInput").value;
	var email = document.getElementById("AddEmailInput").value;
	var age = document.getElementById("AddDOBInput").value;
	var room = document.getElementById("AddRoomInput").value;
	var unit = document.getElementById("AddUnitInput").value;
	var bld = document.getElementById("AddBuildingInput").value;
	addResident(id, name, email, age, room, unit, bld);
}

async function handleSelectField(evt) {
	document.getElementById("newValueDescriptor").style.display = "inline";
	document.getElementById("EditFieldDropdown").innerHTML = evt.currentTarget.id;
	document.getElementById("EditTextInput").style.display = "block";
	document.getElementById("EditSendButton").style.display = "block";
	var id = document.getElementById("EditIDInput").value;
	await fetchResident(id);
}

async function handleEditSend() {
	var id = document.getElementById("EditIDInput").value;
	var field;

	if(document.getElementById("EditFieldDropdown").innerHTML == "name"){field = "name";}
	if(document.getElementById("EditFieldDropdown").innerHTML == "email"){field = "email";}
	if(document.getElementById("EditFieldDropdown").innerHTML == "age"){field = "age";}
	if(document.getElementById("EditFieldDropdown").innerHTML == "room"){field = "roomNumber";}
	if(document.getElementById("EditFieldDropdown").innerHTML == "unit"){field = "unitNumber";}
	if(document.getElementById("EditFieldDropdown").innerHTML == "building"){field = "buildingName";}
	var val = document.getElementById("EditTextInput").value;

	try {
		const response = await fetch('/edit-resident', {
			method: 'PUT',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				data: [id, field, val]
			})
		});
		const responseData = await response.json();
		if(responseData["success"] == false){
			alert("wasn't able to edit the resident")
		} else {
			alert("resident updated")
		}

		r = await fetch('/get-residentdb', {
			method: 'GET'
		});
		rd = await r.json();

		alert(JSON.stringify(rd));
		
	} catch (error) {
		alert(error);
		console.error(error);
	}
}

async function handleDeleteSend() {
	var id = document.getElementById("DeleteIDInput").value;
	try {
		const response = await fetch('/delete-resident', {
			method: 'DELETE',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				id: Number(id)
			})
		});
		const responseData = await response.json();
		if(responseData["success"] == false){
			alert("wasn't able to delete the resident")
		} else {
			alert("resident deleted")
		}

		r = await fetch('/get-residentdb', {
			method: 'GET'
		});
		rd = await r.json();

		alert(JSON.stringify(rd));
		
	} catch (error) {
		alert(error);
		console.error(error);
	}
}


async function fetchResident(id) {
	try {
		const response = await fetch('/get-resident', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				id: Number(id)
			})
		});

		const responseData = await response.json();
		const tableContent = responseData.data;
		if(tableContent.length == 0){
			alert("No resident with the given id found");
		} else {
			if(document.getElementById("EditFieldDropdown").innerHTML == "name"){
				document.getElementById("EditTextInput").value = tableContent[0][2];
			} else if(document.getElementById("EditFieldDropdown").innerHTML == "age"){
				document.getElementById("EditTextInput").value = tableContent[0][1];
			} else if(document.getElementById("EditFieldDropdown").innerHTML == "email"){
				document.getElementById("EditTextInput").value = tableContent[0][3];
			} else if(document.getElementById("EditFieldDropdown").innerHTML == "room"){
				document.getElementById("EditTextInput").value = tableContent[0][4];
			} else if(document.getElementById("EditFieldDropdown").innerHTML == "unit"){
				document.getElementById("EditTextInput").value = tableContent[0][5];
			} else if(document.getElementById("EditFieldDropdown").innerHTML == "building"){
				document.getElementById("EditTextInput").value = tableContent[0][6];
			}
		}
	} catch (error) {
		alert(error);
		console.error(error);
	}
}


async function addResident(id, name, email, age, room, unit, bld) {
	try {
		const response = await fetch('/push-resident', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				data: [id, name, email, age, room, unit, bld]
			})
		});
		const responseData = await response.json();
		if(responseData["success"] == false){
			alert("wasn't able to add the resident")
		} else {
			alert("resident added")
		}

		r = await fetch('/get-residentdb', {
			method: 'GET'
		});
		rd = await r.json();

		alert(JSON.stringify(rd));
		
	} catch (error) {
		alert(error);
		console.error(error);
	}
}


async function handleSelectSend() {
	let query = document.getElementById("selectField").value;
	var q = "WHERE";
	if(query.length == 0){
		alert("invalid query"); return;
	}
	while(query.length > 0){
		if(query.startsWith("id")){ q += " studentId"; query = query.replace('id','');}
		else if(query.startsWith("age")){ q += " age"; query = query.replace('age',''); }
		else if(query.startsWith("name")){ q += " name"; query = query.replace('name',''); }
		else if(query.startsWith("email")){ q += " email"; query = query.replace('email',''); }
		else if(query.startsWith("room")){ q += " roomNumber"; query = query.replace('room',''); }
		else if(query.startsWith("unit")){ q += " unitNumber"; query = query.replace('unit',''); }
		else if(query.startsWith("building")){ q += " buildingName"; query = query.replace('building',''); }
		else {alert("invalid query"); return;}
		if(query.startsWith(" = ")){q += " = "; query = query.replace(' = ','');}
		else {alert("invalid query"); return;}
		if(query.length == 0) {alert("invalid query"); return;}
		if(!query.includes(" and") && !query.includes(" or")){
			//end of query on only val remains
			q +='\''
			q += query;
			q +='\''
			query = "";
		} else {
			if (query.includes(" and")){
				let val = query.substring(0, query.indexOf(' and'));
			} else {
				let val = query.substring(0, query.indexOf(' or'));
			}
			q +='\''
			q += val;
			q +='\''
			query = query.replace(val,'');
			if(query.startsWith(" and ")){
				q += " AND "; query = query.replace(' and ','');
			} else if(query.startsWith(" or ")){
				q += " OR "; query = query.replace(' or ','');
			} else {
				alert("invalid query"); return;
			}
			if(query.length == 0){
				alert("invalid query"); return;
			}
		}
	}

	try {
		const response = await fetch('get-residents-filter', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				query: q
			})
		});

		const responseData = await response.json();
		const tableContent = responseData.data;
		if(tableContent.length == 0){
			alert("No resident with the info found");
		} else {
			alert(JSON.stringify(tableContent));
		}
	} catch (error) {
		alert(error);
		console.error(error);
	}
}