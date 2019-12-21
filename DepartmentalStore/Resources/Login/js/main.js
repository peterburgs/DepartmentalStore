"use strict";

$(document).ready(function () {
    $("#loginForm").on('submit', function (e) {
        e.preventDefault();


        let flag = 1;

        //Validation
        $('#loginForm input').each(function () {
            if ($(this).val() === '') {
                $(this).addClass('warning');
                $(this).attr("placeholder", "* This field can not be empty");
                flag = 0;
            } else {
                $(this).removeClass('warning');
            }
        });

        if (flag) {
            let user = $("#username").val();
            let pwd = $("#password").val();

            let data = {
                username: user,
                password: pwd
            }

            $.ajax({
                url: '/Login/OnPost',
                type: "POST",
                data: data,
                dataType: 'json',
                success: function (res) {
                    if (res.Result === true) {
                        if (res.Admin === true) {
                            window.location.href = "/Admin/Dashboard";
                        } else if (res.Staff === true) {
                            window.location.href = `/Staff-${res.StaffId}/Dashboard`;
                        }
                    } else {
                        alert("Login failed!");
                    }
                }
            });
        }
    });

    $("#loginAsGuestButton").on("click", function (e) {
        e.preventDefault();

        window.location.href = "/Guest/Dashboard";
    });

});
