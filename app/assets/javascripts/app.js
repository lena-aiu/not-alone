// const form = document.getElementById('registrar');
// const input = form.querySelector('input');

// const mainDiv = document.querySelector('.main');
// const ul = document.getElementById('invitedList');

// const div = document.createElement('div');
// const filterLabel = document.createElement('label');
// const filterCheckBox = document.createElement('input');

// filterLabel.textContent ="Hide those who haven't confirm their attendance";
// filterCheckBox.type = 'checkbox';
// div.appendChild(filterLabel);
// div.appendChild(filterCheckBox);
// mainDiv.insertBefore(div,ul);
// filterCheckBox.addEventListener('change', (e) =>{
//     const isChecked = e.target.checked;
//     const lis = ul.children;
//     if(isChecked){
//         for (let i = 0; i < lis.length; i += 1){
//             let li = lis[i];
//             if (li.className === 'responded') {
//                 li.style.display = '';
//             }
//             else {
//                 li.style.display = 'none';
//             }
//         }
//     } else {
//         for (let i = 0; i < lis.length; i += 1){
//             let li = lis[i];
//             li.style.display = '';
//         }

//     }
// });

// function createLI(text) {
//     function createElement(elementName, property, value){
//         const element = document.createElement(elementName);
//         element[property] = value;
//         return element;
//     }
//     function appendToLI(elementName, property, value){
//         const element = createElement(elementName, property, value);
//         li.appendChild(element);
//         return element;
//     }
//    const li = document.createElement('li');
//    appendToLI ('span', 'textContent', text);
//    appendToLI('label','textContent','Confirmed')
//     .appendChild(createElement('input','type','checkbox'));
//    //EDIT BUTTON
//    appendToLI('button', 'textContent', 'edit');
//    //editButton.className = 'edit';
//    //REMOVE BUTTON
//    appendToLI('button','textContent', 'remove');
//    //removeButton.className = 'remove';
//    return li;
// }


// form.addEventListener('submit', (e) => {
//    e.preventDefault();
//    const text = input.value;
//    input.value = '';
//    const li = createLI(text);
//    ul.appendChild(li);
//     //console.log (input.value);
// });
// //EVENT HANDLER FOR CHECKBOX
// ul.addEventListener('change', (e) => {
//     //console.log(e.target.checked);
//     const checkbox = event.target;
//     const checked = checkbox.checked;
//     const listItem = checkbox.parentNode.parentNode;
//     if (checked){
//         listItem.className = 'responded';//Assign a classname to the item of the list
//     }
//     else {
//         listItem.className = '';
//     }
// });
// //EVENT LISTENER FOR REMOVE BUTTONS
// ul.addEventListener('click', (e) => {
//    //if (e.target.tagName === 'BUTTON')
//     const button = event.target;
//     const li = button.parentNode;
//     const ul = li.parentNode;
//     const action = button.textContent;
//     const nameActions = {
//         remove: () => {
//             ul.removeChild(li);  
//         },
//         edit: () => {
//             const span = li.firstElementChild;
//             const input = document.createElement ('input');
//             input.type ='text';
//             input.value = span.textContent;
//             li.insertBefore (input,span);
//             li.removeChild(span);
//             button.textContent = 'save';
//         },
//         save: () =>{
//             const input = li.firstElementChild;
//             const span = document.createElement ('span');
//             span.textContent = input.value;
//             li.insertBefore (span, input);
//             li.removeChild(input);
//             button.textContent = 'edit';
//         }
//     }//close the object
//     //***SELECT AND RUN ACTION IN BUTTON'S NAME */
//     //const nameActions = {
//     //nameActions[action]();
//     if (action === 'remove'){     
//         nameActions.remove();
//     }
//     else if (action === 'edit'){
//         nameActions.edit();
//     }
//     else if (action === 'save'){
//         nameActions.save();
//     }
// });  




    // function removeName(){
    //     ul.removeChild(li); 
    // }
    // function editName(){
    //     const span = li.firstElementChild;
    //     const input = document.createElement ('input');
    //     input.type ='text';
    //     input.value = span.textContent;
    //     li.insertBefore (input,span);
    //     li.removeChild(span);
    //     button.textContent = 'save';

    // }
    // function saveName (){
    //     const input = li.firstElementChild;
    //     const span = document.createElement ('span');
    //     span.textContent = input.value;
    //     li.insertBefore (span, input);
    //     li.removeChild(input);
    //     button.textContent = 'edit';
    // }
//EVENTO BOTON REMOVE POR CLASE
//     if (e.target.className === 'remove'){
//         const li = e.target.parentNode;
//         const ul = li.parentNode;
//         ul.removeChild(li);
//     }
 

// function createLI(text) {
//    const li = document.createElement('li');
//    const span = document.createElement('span');
//    span.textContent = text;
//    li.appendChild(span);
//    //li.textContent = text;
//    const label = document.createElement('label');
//    label.textContent = 'Confirmed';
//    const checkbox = document.createElement('input');
//    checkbox.type = 'checkbox';
//    label.appendChild(checkbox);
//    li.appendChild(label);
//    //EDIT BUTTON
//    const editButton = document.createElement('button');
//    editButton.textContent = 'edit';
//    editButton.className = 'edit';
//    li.appendChild(editButton);
//    //REMOVE BUTTON
//    const removeButton = document.createElement('button');
//    removeButton.textContent = 'remove';
//    removeButton.className = 'remove';
//    li.appendChild(removeButton);
//    return li;
// }
 
 








