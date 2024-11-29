document.getElementById("AddButton").addEventListener("click", handleClickAdd);
document.getElementById("EditButton").addEventListener("click", handleClickEdit);
document.getElementById("DeleteButton").addEventListener("click", handleClickRemove);
document.getElementById("AddSendButton").addEventListener("click", handleAddSend);
document.getElementById("EditSendButton").addEventListener("click", handleEditSend);
document.getElementById("DeleteSendButton").addEventListener("click", handleDeleteSend);
document.getElementById("Name").addEventListener("click", handleSelectField);
document.getElementById("Email").addEventListener("click", handleSelectField);
document.getElementById("DOB").addEventListener("click", handleSelectField);
handleClickAdd();

function handleClickAdd() {
	document.getElementById("AddButton").style.background='#464958';
	document.getElementById("EditButton").style.background='#252c57';
	document.getElementById("DeleteButton").style.background='#252c57';
	document.getElementById("AddDiv").style.display = "block";
	document.getElementById("EditDiv").style.display = "none";
	document.getElementById("RemoveDiv").style.display = "none";
}

function handleClickEdit() {
	document.getElementById("AddButton").style.background='#252c57';
	document.getElementById("EditButton").style.background='#464958';
	document.getElementById("DeleteButton").style.background='#252c57';
	document.getElementById("AddDiv").style.display = "none";
	document.getElementById("EditDiv").style.display = "block";
	document.getElementById("RemoveDiv").style.display = "none";
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
	document.getElementById("AddDiv").style.display = "none";
	document.getElementById("EditDiv").style.display = "none";
	document.getElementById("RemoveDiv").style.display = "block";
}


function handleAddSend() {
	var id = document.getElementById("AddIDInput").value;
	var name = document.getElementById("AddNameInput").value;
	var email = document.getElementById("AddEmailInput").value;
	var dob = document.getElementById("AddDOBInput").value;
	alert(id +" "+ name +" "+ email +" "+ dob);
}

function handleSelectField(evt) {
	document.getElementById("newValueDescriptor").style.display = "inline";
	document.getElementById("EditTimeInput").style.display = "none";
	document.getElementById("EditTextInput").style.display = "none";
	document.getElementById("EditFieldDropdown").innerHTML = evt.currentTarget.id;
	if(evt.currentTarget.id === "DOB"){
		document.getElementById("EditTimeInput").style.display = "block";
	} else {
		document.getElementById("EditTextInput").style.display = "block";
	}
	document.getElementById("EditSendButton").style.display = "block";
}


function handleEditCreateField() {
	var input = document.createElement("input");
	input.type = "text";
	input.className = "textInput";
	buildingsFields.push(input);
	document.getElementById("EditfieldsContainer").appendChild(input);
	var div = document.createElement('div');
	div.id = "DIV";
	document.getElementById("EditfieldsContainer").appendChild(div);
}

function handleEditSend() {
	var name = document.getElementById("EditNameInput").value;
	var textInput = document.getElementById("EditTextInput").value;
	var timeInput = document.getElementById("EditTimeInput").value;
	buildings = [];
	for(i = 0; i < buildingsFields.length; i++){
		buildings[i] = buildingsFields[i].value;
	}
	alert(name +" "+ textInput +" "+ timeInput + " " + buildings);
}

function handleDeleteSend() {
	var name = document.getElementById("DeleteIDInput").value;
	alert(name);
}