//Click button Add New Staff
document.getElementById("addStaff").addEventListener("click", function () {
    document.querySelector(".bg-staff").style.display = "flex";
    document.querySelector(".bg-staff").style.position = "absolute";
});

//Close button Close Add Staff
document.querySelector("#closeAddStaff").addEventListener("click", function () {
    document.querySelector(".bg-staff").style.display = "none";
    window.location.reload();
});

//Close button Close 
document.querySelector("#closeEditStaff").addEventListener("click", function () {
    document.querySelector(".bg-editStaff").style.display = "none";
    window.location.reload();
});

$(document).ready(function () {
    $(".editStaffBtn").click(function () {
        let staffId = $(this).val();

        let data = {
            id: staffId
        };
        $(".bg-editStaff").css("display", "flex");

        $.ajax({
            url: '/Admin/Staff',
            type: "GET",
            data: data,
            success: function (res) {
                $("#editStaffId").val(res.StaffId);
                $("#editStaffName").val(res.StaffName);
                $("#editSalary").val(res.Salary);
                $("#editPhoneNumber").val(res.PhoneNumber);
            }
        });

    });

    $(".deleteStaffBtn").click(function () {
        if (confirm("Are you sure you want to delete this staff?")) {
            let staffId = $(this).val();
            let data = {
                id: staffId
            };

            $.ajax({
                url: '/Admin/Staff/DeleteStaff',
                type: "POST",
                data: data,
                success: function (res) {
                    if (res.Result === true) {
                        alert("Staff has been deleted successfully!")
                        window.location.reload();
                    } else {
                        alert("Delete staff failed!");
                        //window.location.reload();
                    }
                }
            });
        }
    });


    $('#editStaffForm').on('submit', function (e) {
        e.preventDefault();

        let flag = 1;

        //Validation
        $('#editStaffForm input[type=text], #editStaffForm input[type=number]').each(function () {
            if ($(this).val() === '') {
                $(this).addClass('warning');
                $(this).attr("placeholder", "* This field can not be empty");
                flag = 0;
            } else {
                $(this).removeClass('warning');
            }
        });

        if (flag) {
            let name = $('#editStaffName').val();
            let id = $('#editStaffId').val();
            let salary = $('#editSalary').val();
            let phone = $('#editPhoneNumber').val();
            let newPassword = $('#newPassword').val();

            let data = {
                name: name,
                sid: id,
                salary: salary,
                phone: phone,
                newPassword: newPassword,
            };

            $.ajax({
                url: '/Admin/Staff/EditStaff',
                type: "POST",
                data: data,
                dataType: 'json',
                success: function (res) {
                    if (res.Result === true) {
                        alert("Staff has been updated successfully!")
                        window.location.reload();
                    } else {
                        alert("Update new staff failed!");
                    }
                }
            });
        }
    });

    $('#addStaffForm').on('submit', function (e) {
        e.preventDefault();

        let flag = 1;

        //Validation
        $('#addStaffForm input').each(function () {
            if ($(this).val() === '') {
                $(this).addClass('warning');
                $(this).attr("placeholder", "* This field can not be empty");
                flag = 0;
            } else {
                $(this).removeClass('warning');
            }
        });

        if (flag) {
            let name = $('#staffName').val();
            let id = $('#staffId').val();
            let salary = $('#salary').val();
            let phone = $('#phoneNumber').val();
            let username = $('#username').val();
            let password = $('#password').val();

            let data = {
                name: name,
                sid: id,
                salary: salary,
                phone: phone,
                username: username,
                password: password,
            };

            $.ajax({
                url: '/Admin/Staff/AddStaff',
                type: "POST",
                data: data,
                dataType: 'json',
                success: function (res) {
                    if (res.Result === true) {
                        alert("Staff has been added successfully!")
                        window.location.reload();
                    } else {
                        if (res.Message !== undefined) {
                            alert(res.Message);
                        } else {
                            alert("Add new staff failed!");
                        }
                    }
                }
            });
        }
    });

    $('#searchForm').on('submit', function (e) {
        e.preventDefault();

        let staffName = $("#search").val();

        if (staffName === "") {
            window.location.href = `/Admin/Staffs`;
        } else {
            window.location.href = `/Admin/Staffs/Search-${staffName}`;
        }

    });

});