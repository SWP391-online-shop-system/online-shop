/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
$(document).ready(function () {
    $('#dataTableHover').DataTable({
        columns: [
            {searchable: true},
            {searchable: true},
            {searchable: false},
            {searchable: false},
            {searchable: false},
            {searchable: false},
            {searchable: false}],
        search: {
            placeholder: 'Type search here'
        }
    }); // ID From dataTable with Hover
});

