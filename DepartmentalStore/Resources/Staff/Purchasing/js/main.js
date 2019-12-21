"use strict()";

class Item {
    constructor(id, name, rating, quantity, value) {
        this.id = id;
        this.name = name;
        this.rating = rating;
        this.quantity = quantity;
        this.value = value;
    }
}

$(document).ready(function () {
    let total = 0;

    let items = [];

    //Add a row to the table
    $("#add").click(function () {
        //Declare variables to submit to table

        if ($("#batchId").val() === "") {
            alert("Please enter item ID");
        } else {

            $.ajax({
                url: `/Staff/Batch-${$("#batchId").val()}/Product`,
                type: "GET",
                success: function (res) {
                    if (res.Message === true) {

                        let productName = res.ProductName;
                        let productRating = parseInt(res.ProductRating);
                        let productQuantity = parseInt(res.ProductQuantity);
                        let inputItemId = $("#batchId").val();
                        let inputQuantity = parseInt($("#quantity").val());

                        if ($("#quantity").val() === "") {
                            inputQuantity = 1;
                        }

                        let value = inputQuantity * productRating;

                        let item = items.find(function (element) {
                            return element.id === inputItemId;
                        });

                        if (item !== undefined) {
                            let oldQuantity = item.quantity;
                            let newQuantity = oldQuantity + inputQuantity;
                            if (newQuantity > productQuantity) {
                                alert("Sorry, We dont have enough amount of this batch!");
                            } else {
                                item.quantity = newQuantity;
                                item.value += value;

                                total += value;
                                $("#totalValue").val(total);

                                $(`#item-${item.id} td:nth-child(3)`).text(item.quantity.toLocaleString());

                                $(`#item-${item.id} td:nth-child(4)`).text(item.value.toLocaleString());

                            }
                        } else {

                            if (inputQuantity > productQuantity) {
                                alert("You have chosen the maximum number of this batch!");
                            } else {

                                items.push(new Item(inputItemId, productName, productRating, inputQuantity, value));

                                total += value;
                                $("#totalValue").val(total);
                                //Process data
                                $("#table").append(
                                    `<tr id="item-${inputItemId}">` +
                                    "<td style=\"width: 30%;\">" +
                                    productName +
                                    "</td>" +
                                    "<td style=\"width: 20%;\">" +
                                    productRating.toLocaleString() +
                                    "</td>" +
                                    "<td style=\"width: 20%;\">" +
                                    inputQuantity.toLocaleString() +
                                    "</td>" +
                                    "<td style=\"width: 20%;\">" +
                                    value.toLocaleString() +
                                    "</td>" +
                                    "<td style=\"width: 10%;\">" +
                                    `<button class="btn btn-sm btn-danger delete" id="delete-${inputItemId}"  ><i class="material-icons">delete_forever</i></button>` +
                                    "</td>" +
                                    "</tr>"
                                );

                                $(`#delete-${inputItemId}`).click(function () {
                                    let item = items.find(function (element) {
                                        return element.id === inputItemId;
                                    });
                                    total -= item.value;
                                    $("#totalValue").val(total);
                                    $(`#item-${inputItemId}`).remove();
                                    let index = items.indexOf(item);
                                    items.splice(index, 1);
                                });

                            }
                        }
                    } else {
                        alert("Cannot find product!");
                    }
                    $("#batchId").val("");
                    $("#quantity").val("");
                }
            });
        }
    });

    $("#cash").keydown(function () {
        if ($("#totalValue").val() === "") {
            $("#cash").attr("readonly", "readonly");
            alert("Please enter at least one product!");
        } else {
            $("#cash").removeAttr("readonly");
        }
    });

    $("#cash").keyup(function () {
        let cash = parseInt($("#cash").val());
        let change;
        console.log(total);
        console.log(cash);
        if (cash > total) {
            change = cash - total;
            console.log(change);
            $("#change").val(change);
        } else {
            $("#change").val(0);
        }
    });

    $("#cancel").click(function () {
        window.location.reload();
    });

    $("#confirm").click(function () {
        if (items.length == 0) {
            alert("There is nothing to confirm!");
        } else {
            if ($("#cash").val() == "") {
                alert("Please enter cash to confirm");
            } else {
                if (parseInt($("#cash").val()) < total) {
                    alert("Not enough money!");
                } else {
                    let data;
                    if ($("#customerId").val() !== "") {
                        data = {
                            items: items,
                            totalValue: total,
                            cid: $("#customerId").val()
                        };
                    } else {
                        data = {
                            items: items,
                            totalValue: total,
                        };
                    }

                    $.ajax({
                        url: "/Staff/Purchasing/AddPurchase",
                        type: "POST",
                        data: data,
                        datatype: "json",
                        success: function (res) {
                            if (res.Result === true) {
                                alert("Transaction successfully!");

                                let time = ["Time: ", `${res.Time}`];
                                let t = time.join(",");

                                let staffName = ["Staff Name: ", `${res.StaffName}`];
                                let s = staffName.join(",");

                                let value = ["Total: ", `${total}`];
                                let v = value.join(",");

                                let headers = ["Product Name", "Rating", "Quantity", "Value"];
                                let h = headers.join(",");

                                let csvContent = "data:text/csv;charset=utf-8,";
                                csvContent += t + "\r\n";
                                csvContent += s + "\r\n";
                                csvContent += v + "\r\n";
                                csvContent += h + "\r\n";

                                let products = [];

                                items.forEach(function(item) {
                                    products.push([item.name, item.rating, item.quantity, item.value]);
                                });

                                products.forEach(function (product) {
                                    let r = product.join(",");
                                    csvContent += r + "\r\n";
                                });

                                var encodedUri = encodeURI(csvContent);
                                var link = document.createElement("a");
                                link.setAttribute("href", encodedUri);
                                link.setAttribute("download", "purchase_detail.csv");
                                document.body.appendChild(link);
                                link.click();

                                window.location.reload();
                            } else {
                                alert(res.Message);
                                alert("Transaction failed!");
                                window.location.reload();
                            }
                        }

                    });
                }
            }
        }
    });
});
