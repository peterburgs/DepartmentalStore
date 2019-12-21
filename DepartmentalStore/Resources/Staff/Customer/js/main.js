//Click button Add New Staff
document.getElementById("addCustomer").addEventListener("click", function () {
    document.querySelector(".bg-customer").style.display = "flex";
    document.querySelector(".bg-customer").style.position = "absolute";
});

//Close button Close Add Staff
document.querySelector("#closeAddCustomer").addEventListener("click", function () {
    document.querySelector(".bg-customer").style.display = "none";
    window.location.reload();
});

//Close button Close 
document.querySelector("#closeEditCustomer").addEventListener("click", function () {
    document.querySelector(".bg-editCustomer").style.display = "none";
    window.location.reload();
});

$(document).ready(function () {

    $(".editCustomerBtn").click(function () {
        let customerId = $(this).val();

        let data = {
            id: customerId
        };
        $(".bg-editCustomer").css("display", "flex");

        $.ajax({
            url: '/Staff/Customer',
            type: "GET",
            data: data,
            success: function (res) {
                $("#editCustomerId").val(res.CustomerId);
                $("#editCustomerName").val(res.CustomerName);
                $("#editPhoneNumber").val(res.PhoneNumber);
                $("#editPoints").val(res.Points);
            }
        });

    });

    $(".deleteCustomerBtn").click(function () {
        if (confirm("Are you sure you want to delete this customer?")) {
            let customerId = $(this).val();
            let data = {
                id: customerId
            };

            $.ajax({
                url: '/Staff/Customer/DeleteCustomer',
                type: "POST",
                data: data,
                success: function (res) {
                    if (res.Result === true) {
                        alert("Customer has been deleted successfully!")
                        window.location.reload();
                    } else {
                        alert("Delete customer failed!");
                        //window.location.reload();
                    }
                }
            });
        }
    });


    $('#editCustomerForm').on('submit', function (e) {
        e.preventDefault();

        let flag = 1;

        //Validation
        $('#editCustomerForm input[type=text], #editCustomerForm input[type=number]').each(function () {
            if ($(this).val() === '') {
                $(this).addClass('warning');
                $(this).attr("placeholder", "* This field can not be empty");
                flag = 0;
            } else {
                $(this).removeClass('warning');
            }
        });

        if (flag) {
            let name = $('#editCustomerName').val();
            let id = $('#editCustomerId').val();
            let phone = $('#editPhoneNumber').val();
            let points = $('#editPoints').val();

            let data = {
                name: name,
                cid: id,
                phone: phone,
                points: points
            };

            $.ajax({
                url: '/Staff/Customer/EditCustomer',
                type: "POST",
                data: data,
                dataType: 'json',
                success: function (res) {
                    if (res.Result === true) {
                        alert("Customer has been updated successfully!")
                        window.location.reload();
                    } else {
                        alert("Update new customer failed!");
                    }
                }
            });
        }
    });

    $('#addCustomerForm').on('submit', function (e) {
        e.preventDefault();

        let flag = 1;

        //Validation
        $('#addCustomerForm input[type=text], #addCustomerForm input[type=number]').each(function () {
            if ($(this).val() === '') {
                $(this).addClass('warning');
                $(this).attr("placeholder", "* This field can not be empty");
                flag = 0;
            } else {
                $(this).removeClass('warning');
            }
        });

        if (flag) {
            let name = $('#customerName').val();
            let id = $('#customerId').val();
            let phone = $('#phoneNumber').val();
            let points = $('#points').val();

            let data = {
                name: name,
                cid: id,
                phone: phone,
                points: points
            };

            $.ajax({
                url: '/Staff/Customer/AddCustomer',
                type: "POST",
                data: data,
                dataType: 'json',
                success: function (res) {
                    if (res.Result === true) {
                        alert("Customer has been added successfully!")
                        window.location.reload();
                    } else {
                        alert("Add new customer failed!");
                    }
                }
            });
        }
    });

});