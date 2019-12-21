//Click button Add New Product
document.getElementById("addProduct").addEventListener("click", function () {
    document.querySelector(".bg-product").style.display = "flex";
    document.querySelector(".bg-product").style.position = "absolute";
});

//Close button Close Add Product
document.querySelector("#closeAddProduct").addEventListener("click", function () {
    document.querySelector(".bg-product").style.display = "none";
    window.location.reload();
});

//Click button Add New Batch
//document.getElementById("addBatch").addEventListener("click", function () {
//    document.querySelector(".bg-batch").style.display = "flex";
//    document.querySelector(".bg-batch").style.position = "absolute";
//});

//Close button Close Add Batch
document.querySelector("#closeAddBatch").addEventListener("click", function () {
    document.querySelector(".bg-batch").style.display = "none";
    window.location.reload();
});

//Close button Close 
document.querySelector("#closeEditProduct").addEventListener("click", function () {
    document.querySelector(".bg-edit").style.display = "none";
    window.location.reload();
});

$(document).ready(function () {

    //For Batch
    //Add DatePicker
    $("#importDate").datepicker({ dateFormat: 'dd-mm-yy' });
    $("#importDate").val($.datepicker.formatDate('dd-mm-yy', new Date()));

    $("#expirationDate").datepicker({ dateFormat: 'dd-mm-yy' });

    $(".addBatchBtn").click(function () {
        let productId = $(this).val();

        let data = {
            pid: productId
        };

        $.ajax({
            url: '/Admin/Batch/GetBatchId',
            type: 'GET',
            data: data,
            success: function (res) {
                let bid = res.bid + 1;
                $('#batchId').val(bid);
                $('#batchProductId').val(res.pid);
                $(".bg-batch").css("display", "flex");
            }
        });
    });

    $(".editProductBtn").click(function () {
        let productId = $(this).val();

        let data = {
            id: productId
        };

        $.ajax({
            url: '/Admin/Product',
            type: "GET",
            data: data,
            success: function (res) {
                $("#editProductId").val(res.ProductId);
                $("#editProductName").val(res.ProductName);
                $("#editProductVender").val(res.ProductVender);
                $("#editProductType").val(res.ProductType);
                $("#editProductUnit").val(res.ProductUnit);
                $("#editProductRating").val(res.ProductRating);
                $(".bg-edit").css("display", "flex");
            }
        });

    });

    $(".deleteProductBtn").click(function () {
        if (confirm("Are you sure you want to delete this product?")) {
            let productId = $(this).val();
            let data = {
                id: productId
            };

            $.ajax({
                url: '/Admin/Product/DeleteProduct',
                type: "POST",
                data: data,
                success: function (res) {
                    if (res.Result === true) {
                        alert("Product has been deleted successfully!")
                        window.location.reload();
                    } else {
                        alert("Delete product failed!");
                    }
                }
            });
        }
    });


    $('#editProductForm').on('submit', function (e) {
        e.preventDefault();

        let flag = 1;

        //Validation
        $('#editProductForm input[type=text], #editProductForm input[type=number]').each(function () {
            if ($(this).val() === '') {
                $(this).addClass('warning');
                $(this).attr("placeholder", "* This field can not be empty");
                flag = 0;
            } else {
                $(this).removeClass('warning');
            }
        });

        if (flag) {
            let name = $('#editProductName').val();
            let id = $('#editProductId').val();
            let vender = $('#editProductVender').val();
            let rating = $('#editProductRating').val();
            let type = $('#editProductType option:selected').val();
            let unit = $('#editProductUnit option:selected').val();
            let image1 = $('#EditImage1').prop('files')[0];
            let image2 = $('#EditImage2').prop('files')[0];
            let image3 = $('#EditImage3').prop('files')[0];

            let data = new FormData();

            data.append("name", name);
            data.append("pid", id);
            data.append("vendor", vender);
            data.append("price", rating);
            data.append("type", type);
            data.append("unit", unit);
            data.append("did", "1");
            data.append("Image1", image1);
            data.append("Image2", image2);
            data.append("Image3", image3);

            $.ajax({
                url: '/Admin/Product/EditProduct',
                type: "POST",
                data: data,
                dataType: 'json',
                processData: false,
                contentType: false,
                success: function (res) {
                    if (res.Result === true) {
                        alert("Product has been updated successfully!")
                        window.location.reload();
                    } else {
                        alert("Update product failed!");
                    }
                }
            });
        }
    });
    //Add Product

    $('#addProductForm').on('submit', function (e) {
        e.preventDefault();

        let flag = 1;

        //Validation
        $('#addProductForm input[type=text], #addProductForm input[type=number]').each(function () {
            if ($(this).val() === '') {
                $(this).addClass('warning');
                $(this).attr("placeholder", "* This field can not be empty");
                flag = 0;
            } else {
                $(this).removeClass('warning');
            }
        });

        if (flag) {
            let name = $('#productName').val();
            let id = $('#productId').val();
            let vender = $('#productVender').val();
            let rating = $('#productRating').val();
            let type = $('#productType option:selected').val();
            let unit = $('#productUnit option:selected').val();
            let image1 = $('#AddImage1').prop('files')[0];
            let image2 = $('#AddImage2').prop('files')[0];
            let image3 = $('#AddImage3').prop('files')[0];

            let data = new FormData();
            data.append("name", name);
            data.append("pid", id);
            data.append("vendor", vender);
            data.append("price", rating);
            data.append("type", type);
            data.append("unit", unit);
            data.append("quantity", 0);
            data.append("did", "1");
            data.append("Image1", image1);
            data.append("Image2", image2);
            data.append("Image3", image3);

            $.ajax({
                url: '/Admin/Product/AddProduct',
                type: "POST",
                data: data,
                dataType: 'json',
                processData: false,
                contentType: false,
                success: function (res) {
                    if (res.Result === true) {
                        alert("Product has been added successfully!")
                        window.location.reload();
                    } else {
                        alert(res.Message);
                    }
                }
            });
        }
    });

    $('#addBatchForm').on('submit', function (e) {
        e.preventDefault();

        let flag = 1;

        //Validation
        $('#addBatchForm input').each(function () {
            if ($(this).val() === '') {
                $(this).addClass('warning');
                $(this).attr("placeholder", "* This field can not be empty");
                flag = 0;
            } else {
                $(this).removeClass('warning');
            }
        });

        if (flag) {
            let bid = $('#batchId').val();
            let importDate = $('#importDate').val();
            let expirationDate = $('#expirationDate').val();
            let quantity = $('#quantity').val();
            let pid = $('#batchProductId').val();

            let data = {
                bid: bid,
                importDate: importDate,
                expirationDate: expirationDate,
                quantity: quantity,
                pid: pid
            };

            $.ajax({
                url: '/Admin/Batch/AddBatch',
                type: "POST",
                data: data,
                dataType: 'json',
                success: function (res) {
                    if (res.Result === true) {
                        alert("Batch has been added successfully!")
                        window.location.reload();
                    } else {
                        //alert("Add new batch failed!");
                        alert(res.Message);
                    }
                }
            });
        }
    });

    $('#searchForm').on('submit', function (e) {
        e.preventDefault();

        let productName = $("#search").val();

        if (productName === "") {
            window.location.href = `/Admin/Products`;
        } else {
            window.location.href = `/Admin/Products/Search-${productName}`;
        }

    });

});