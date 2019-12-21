using DepartmentalStore.Models;
using DepartmentalStore.Viewmodels;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Core.Objects;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Services.Description;
using DepartmentalStore.App_Start;

namespace DepartmentalStore.Controllers
{
    /// <summary>
    /// Admin controller
    /// </summary>
    [AdminAuthenticationFilter]
    public class AdminController : Controller
    {
        #region Dashboard
        [Route("Admin/Dashboard")]
        [HttpGet]
        public ActionResult Dashboard()
        {
            DashboardViewModel viewModel = new DashboardViewModel();
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                try
                {
                    viewModel.TotalCustomers = context.Customers.SqlQuery("select * from dbo.fn_GetAllCustomers()").ToList().Count;
                    viewModel.TotalProducts = context.Products.SqlQuery("select * from dbo.fn_GetAllProducts()").ToList().Count;
                    viewModel.TotalStaffs = context.Staffs.SqlQuery("select * from dbo.fn_GetAllStaffs()").ToList().Count;
                    viewModel.DailyIncome = context.Database.SqlQuery<double?>("select dbo.fn_GetDailyIncome()").FirstOrDefault();
                    viewModel.MonthlyIncome = context.Database.SqlQuery<DashBoardMonthlyIncome>("Select * from dbo.fn_GetMonthlyIncome()").FirstOrDefault();
                }
                catch
                {

                }
            }
            return View(viewModel);
        }

        //Export Financial Report
        [HttpGet]

        public FileResult FinancialReport()
        {
            //try
            //{
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                LocalReport localReport = new LocalReport();
                localReport.ReportPath = Server.MapPath("~/Report/FinancialReport.rdlc");


                ReportDataSource reportDataSource = new ReportDataSource();
                reportDataSource.Name = "MonthlyIncomeDataset";
                reportDataSource.Value = context.MonthlyIncomes.ToList();

                localReport.DataSources.Add(reportDataSource);

                string reportType = "pdf";
                string mimeType;
                string encoding;
                string fileNameExtension = "pdf";
                Warning[] warnings;
                string[] streams;
                byte[] renderedBytes;


                renderedBytes = localReport.Render(reportType, "", out mimeType, out encoding,
                     out fileNameExtension, out streams, out warnings);

                Response.AddHeader("Content-Disposition", "attachment; filename=FinancialReport." + fileNameExtension);
                return File(renderedBytes, fileNameExtension);
            }
            //}
            //catch
            //{
            //    return File("", "");
            //}

        }
        //End of Financial Report


        //Export Product Report
        public FileResult ProductReport(string ReportType)
        {
            try
            {
                using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
                {
                    LocalReport localReport = new LocalReport();
                    localReport.ReportPath = Server.MapPath("~/Report/ProductReport.rdlc");


                    ReportDataSource reportDataSource = new ReportDataSource();
                    reportDataSource.Name = "ProductDataset";
                    reportDataSource.Value = context.Products.ToList();

                    localReport.DataSources.Add(reportDataSource);

                    string reportType = ReportType;
                    string mimeType;
                    string encoding;
                    string fileNameExtension;
                    if (reportType == "pdf")
                    {
                        fileNameExtension = "pdf";
                    }
                    else
                    {
                        if (reportType == "excel")
                        {
                            fileNameExtension = "xlsx";
                        }
                        else
                        {
                            fileNameExtension = "docx";
                        }
                    }
                    Warning[] warnings;
                    string[] streams;
                    byte[] renderedBytes;


                    renderedBytes = localReport.Render(reportType, "", out mimeType, out encoding,
                        out fileNameExtension, out streams, out warnings);
                    Response.AddHeader("Content-Disposition", "attachment; filename=ProductReport." + fileNameExtension);
                    return File(renderedBytes, fileNameExtension);
                }
            }
            catch
            {
                return File("", "");
            }

        }

        //End of Product Report



        //Export Staff Report
        public FileResult StaffReport(string ReportType)
        {
            try
            {
                using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
                {
                    LocalReport localReport = new LocalReport();
                    localReport.ReportPath = Server.MapPath("~/Report/StaffReport.rdlc");


                    ReportDataSource reportDataSource = new ReportDataSource();
                    reportDataSource.Name = "StaffDataset";
                    reportDataSource.Value = context.Staffs.ToList();

                    localReport.DataSources.Add(reportDataSource);

                    string reportType = ReportType;
                    string mimeType;
                    string encoding;
                    string fileNameExtension;
                    if (reportType == "pdf")
                    {
                        fileNameExtension = "pdf";
                    }
                    else
                    {
                        if (reportType == "excel")
                        {
                            fileNameExtension = "xlsx";
                        }
                        else
                        {
                            fileNameExtension = "docx";
                        }
                    }
                    Warning[] warnings;
                    string[] streams;
                    byte[] renderedBytes;


                    renderedBytes = localReport.Render(reportType, "", out mimeType, out encoding,
                        out fileNameExtension, out streams, out warnings);
                    Response.AddHeader("Content-Disposition", "attachment; filename=StaffReport." + fileNameExtension);
                    return File(renderedBytes, fileNameExtension);
                }
            }
            catch
            {
                return File("", "");
            }

        }

        //End of Staff Report


        //Export Customer Report
        public FileResult CustomerReport(string ReportType)
        {
            try
            {
                using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
                {
                    LocalReport localReport = new LocalReport();
                    localReport.ReportPath = Server.MapPath("~/Report/CustomerReport.rdlc");


                    ReportDataSource reportDataSource = new ReportDataSource();
                    reportDataSource.Name = "CustomerDataset";
                    reportDataSource.Value = context.Customers.ToList();

                    localReport.DataSources.Add(reportDataSource);

                    string reportType = ReportType;
                    string mimeType;
                    string encoding;
                    string fileNameExtension;
                    if (reportType == "pdf")
                    {
                        fileNameExtension = "pdf";
                    }
                    else
                    {
                        if (reportType == "excel")
                        {
                            fileNameExtension = "xlsx";
                        }
                        else
                        {
                            fileNameExtension = "docx";
                        }
                    }
                    Warning[] warnings;
                    string[] streams;
                    byte[] renderedBytes;


                    renderedBytes = localReport.Render(reportType, "", out mimeType, out encoding,
                        out fileNameExtension, out streams, out warnings);
                    Response.AddHeader("Content-Disposition", "attachment; filename=CustomerReport." + fileNameExtension);
                    return File(renderedBytes, fileNameExtension);
                }
            }
            catch
            {
                return File("", "");
            }

        }

        //End of Customer Report
        #endregion

        #region Product

        /// <summary>
        /// Return product view
        /// </summary>
        /// <returns></returns>
        [Route("Admin/Products")]
        [HttpGet]
        public ActionResult Product()
        {
            ProductViewModel viewModel = new ProductViewModel();
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                viewModel.Products = context.Products.SqlQuery("select * from dbo.fn_GetAllProducts()").ToList();
                viewModel.AllProducts = context.Products.SqlQuery("select * from dbo.fn_GetAllProductsIncludingDeleted()").ToList();
            }
            return View(viewModel);
        }

        /// <summary>
        /// Add a product to database
        /// </summary>
        /// <param name="product"></param>
        /// <returns></returns>
        [Route("Admin/Product/AddProduct")]
        [HttpPost]
        public JsonResult AddProduct(Product product, HttpPostedFileBase Image1, HttpPostedFileBase Image2, HttpPostedFileBase Image3)
        {
            if (Image1 == null || Image2 == null || Image3 == null)
            {
                return Json(new { Result = false, Message = "Please upload 3 images of this product" });
            }
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                //try
                //{
                context.Database.ExecuteSqlCommand("exec sp_Pro_Insert @pid, @name, @price, @vendor, @type, @unit, @quantity, @did", new SqlParameter[]
                {
                        new SqlParameter("@pid", product.pid),
                        new SqlParameter("@name", product.name),
                        new SqlParameter("@price", product.price),
                        new SqlParameter("@vendor", product.vendor),
                        new SqlParameter("@type", product.type),
                        new SqlParameter("@unit", product.unit),
                        new SqlParameter("@quantity", product.quantity),
                        new SqlParameter("@did", product.did)
                });

                addImage(product.pid, context, Image1, 1);
                addImage(product.pid, context, Image2, 2);
                addImage(product.pid, context, Image3, 3);
                return Json(new { Result = true });
                //}
                //catch (SqlException e)
                //{
                //    return Json(new { Result = false, Message = e.Message });
                //}
            }

        }

        private void addImage(string pid, DepartmentalStoreManagementEntities context, HttpPostedFileBase image, int index)
        {
            //create relative path
            string relativePath = "/Resources/Admin/ProductDetail/images/" + pid + index + ".png";

            //create physical path
            string physicalPath = Server.MapPath(relativePath);

            // check if the image folder exists
            string imageFolder = System.IO.Path.GetDirectoryName(physicalPath);
            if (!System.IO.Directory.Exists(imageFolder))
            {
                System.IO.Directory.CreateDirectory(imageFolder);
            }

            // save the image to physical path
            image.SaveAs(physicalPath);

            // save image Url to database
            context.Database.ExecuteSqlCommand("exec sp_ImageReference_Insert @id, @path, @pid", new SqlParameter[]
            {
                            new SqlParameter("@id", pid + index),
                            new SqlParameter("@path", relativePath),
                            new SqlParameter("@pid", pid),
            });
        }

        /// <summary>
        /// Return a specific product from database to the view
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Route("Admin/Product")]
        [HttpGet]
        public JsonResult GetProduct(string id)
        {
            Product product;
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                try
                {
                    product = context.Products.SqlQuery("select * from dbo.fn_GetProductById(@id)", new SqlParameter("@id", id)).FirstOrDefault();

                    return Json(new
                    {
                        ProductName = product.name,
                        ProductId = product.pid,
                        ProductVender = product.vendor,
                        ProductType = product.type,
                        ProductUnit = product.unit,
                        ProductRating = product.price
                    }, JsonRequestBehavior.AllowGet);
                }
                catch (SqlException e)
                {
                    throw new Exception(e.Message);
                }
            }
        }

        /// <summary>
        /// Update changes of a product to the database
        /// </summary>
        /// <param name="product"></param>
        /// <returns></returns>
        [Route("Admin/Product/EditProduct")]
        [HttpPost]
        public JsonResult EditProduct(Product product, HttpPostedFileBase Image1, HttpPostedFileBase Image2, HttpPostedFileBase Image3)
        {
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                try
                {
                    context.Database.ExecuteSqlCommand("exec sp_Pro_Update @pid, @name, @price, @vendor, @type, @unit, @did", new SqlParameter[]
                    {
                        new SqlParameter("@pid", product.pid),
                        new SqlParameter("@name", product.name),
                        new SqlParameter("@price", product.price),
                        new SqlParameter("@vendor", product.vendor),
                        new SqlParameter("@type", product.type),
                        new SqlParameter("@unit", product.unit),
                        new SqlParameter("@did", product.did)
                    });
                    if (Image1 != null)
                    {
                        editImage(product.pid, Image1, 1);
                    }
                    if (Image2 != null)
                    {
                        editImage(product.pid, Image2, 2);
                    }
                    if (Image3 != null)
                    {
                        editImage(product.pid, Image3, 3);
                    }
                    return Json(new { Result = true });
                }
                catch
                {
                    return Json(new { Result = false });
                }
            }

        }

        private void editImage(string pid, HttpPostedFileBase image, int index)
        {
            //create relative path
            string relativePath = "/Resources/Admin/ProductDetail/images/" + pid + index + ".png";

            //create physical path
            string physicalPath = Server.MapPath(relativePath);

            // check if the image folder exists
            string imageFolder = System.IO.Path.GetDirectoryName(physicalPath);
            if (!System.IO.Directory.Exists(imageFolder))
            {
                System.IO.Directory.CreateDirectory(imageFolder);
            }

            // save the image to physical path
            image.SaveAs(physicalPath);
        }

        /// <summary>
        /// Delete a product in database
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Route("Admin/Product/DeleteProduct")]
        [HttpPost]
        public JsonResult DeleteProduct(string id)
        {
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                try
                {
                    context.Database.ExecuteSqlCommand("exec sp_Pro_Delete @pid", new SqlParameter("@pid", id));
                    return Json(new { Result = true });
                }
                catch
                {
                    return Json(new { Result = false });
                }
            }

        }

        /// <summary>
        /// Return product view with a specific product
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        [Route("Admin/Products/Search-{name}")]
        [HttpGet]
        public ActionResult SearchProduct(string name)
        {
            ProductViewModel viewModel = new ProductViewModel();
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                viewModel.Products = context.Products.SqlQuery("select * from dbo.fn_GetProductById(@pid)", new SqlParameter("@pid", $"%{name}%")).ToList();
                if (viewModel.Products.Count == 0)
                {
                    viewModel.Products = context.Products.SqlQuery("select * from dbo.fn_GetProductByName(@name)", new SqlParameter("@name", $"%{name}%")).ToList();
                }
                viewModel.AllProducts = context.Products.SqlQuery("select * from dbo.fn_GetAllProductsIncludingDeleted()").ToList();
                if (viewModel.Products.Count == 0)
                {
                    return View("Error");
                }
            }
            return View("Product", viewModel);
        }

        /// <summary>
        /// Return a view with product detail such as images and information
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Route("Admin/ProductDetail-{id}")]
        [HttpGet]
        public ActionResult ProductDetail(string id)
        {
            ProductDetailViewModel viewModel = new ProductDetailViewModel();
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                viewModel.Product = context.Products.SqlQuery("Select * from dbo.fn_GetProductById(@pid)", new SqlParameter("@pid", id)).FirstOrDefault();
                viewModel.Batch = context.Batches.SqlQuery("Select * from dbo.fn_GetBatchByProductId(@pid)", new SqlParameter("@pid", id)).FirstOrDefault();
                viewModel.ImageReferences = context.ImageReferences.SqlQuery("Select * from dbo.fn_GetImageReferenceByProductId(@pid)", new SqlParameter("@pid", id)).ToList();
            }
            return View(viewModel);
        }
        #endregion

        #region Batch

        /// <summary>
        /// Add a batch to database
        /// </summary>
        /// <param name="batch"></param>
        /// <returns></returns>
        [Route("Admin/Batch/AddBatch")]
        [HttpPost]
        public JsonResult AddBatch(string bid, string importDate, string expirationDate, string quantity, string pid)
        {
            Batch batch = new Batch()
            {
                bid = bid,
                importDate = DateTime.ParseExact(importDate, "dd-MM-yyyy", CultureInfo.InvariantCulture),
                expirationDate = DateTime.ParseExact(expirationDate, "dd-MM-yyyy", CultureInfo.InvariantCulture),
                quantity = int.Parse(quantity),
                pid = pid
            };
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                try
                {
                    context.Database.ExecuteSqlCommand("exec sp_Batch_Insert @bid, @importDate, @expirationDate, @quantity, @pid", new SqlParameter[]
                    {
                        new SqlParameter("@bid", batch.bid),
                        new SqlParameter("@importDate", batch.importDate),
                        new SqlParameter("@expirationDate", batch.expirationDate),
                        new SqlParameter("@quantity", batch.quantity),
                        new SqlParameter("@pid", batch.pid),
                    });
                    return Json(new { Result = true });
                }
                catch (SqlException e)
                {
                    return Json(new { Result = false, Message = e.Message });
                }
            }

        }

        /// <summary>
        /// Return a product with batch id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Route("Admin/Batch-{id}/Product")]
        [HttpGet]
        public JsonResult GetProductOfBatch(string id)
        {
            Product product = null;
            Batch batch = null;
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                batch = context.Batches.SqlQuery("Select * from dbo.fn_GetBatchById(@bid)", new SqlParameter("@bid", id)).FirstOrDefault();
                if (batch != null)
                {
                    product = context.Products.SqlQuery("select * from dbo.fn_GetProductById(@pid)", new SqlParameter("@pid", batch.pid)).FirstOrDefault();
                }
            }
            if (product == null)
            {
                return Json(new { Message = false }, JsonRequestBehavior.AllowGet);
            }
            return Json(new
            {
                Message = true,
                ProductName = product.name,
                ProductRating = product.price,
                ProductQuantity = batch.quantity
            },
            JsonRequestBehavior.AllowGet); ;
        }

        /// <summary>
        /// Return id of latest batch of a specific product
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("Admin/Batch/GetBatchId")]
        public JsonResult GetBatchId(string pid)
        {
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                List<Batch> batches = context.Batches.Where(b => b.pid == pid).Select(b => b).ToList();
                int max = 0;
                if (batches.Count == 0)
                {
                    max = int.Parse(pid) * 1000;
                    return Json(new { pid = pid, bid = max }, JsonRequestBehavior.AllowGet);
                }
                foreach (var batch in batches)
                {
                    if (int.Parse(batch.bid) > max)
                    {
                        max = int.Parse(batch.bid);
                    }
                }
                return Json(new { pid = pid, bid = max }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion

        #region Purchasing

        /// <summary>
        /// Return purchasing view
        /// </summary>
        /// <returns></returns>
        [Route("Admin/Purchasing")]
        [HttpGet]
        public ActionResult Purchasing()
        {
            return View();
        }

        /// <summary>
        /// Handle purchase action
        /// </summary>
        /// <param name="items"></param>
        /// <param name="totalValue"></param>
        /// <param name="cid"></param>
        /// <returns></returns>
        [Route("Admin/Purchasing/AddPurchase")]
        [HttpPost]
        public JsonResult AddPurchase(List<PurchaseItem> items, double totalValue, string cid)
        {
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                List<Purchase> purchases = context.Purchases.SqlQuery("Select * from dbo.fn_GetAllPurchases()").ToList();
                int pcid = purchases.Count + 1;
                string sid = "0";

                if (cid == null)
                {
                    context.Database.ExecuteSqlCommand("exec sp_Purchase_Insert @pcid, @sid, null, @date, @value", new SqlParameter[]
                    {
                        new SqlParameter("@pcid", pcid),
                        new SqlParameter("@sid", sid),
                        new SqlParameter("@date", DateTime.Now),
                        new SqlParameter("@value", totalValue),
                    });
                }
                else
                {
                    Customer cus = context.Customers.SqlQuery("Select * from dbo.fn_GetCustomerById(@cid)",
                        new SqlParameter("@cid", cid)).FirstOrDefault();
                    if (cus == null)
                    {
                        return Json(new { Result = false, Message = "Cannot find customer" });
                    }
                    context.Database.ExecuteSqlCommand("exec sp_Purchase_Insert @pcid, @sid, @cid, @date, @value", new SqlParameter[]
                    {
                        new SqlParameter("@pcid", pcid),
                        new SqlParameter("@sid", sid),
                        new SqlParameter("@cid", cid),
                        new SqlParameter("@date", DateTime.Now),
                        new SqlParameter("@value", totalValue),
                    });
                }

                foreach (var item in items)
                {

                    Batch batch = context.Batches.SqlQuery("Select * from dbo.fn_GetBatchById(@bid)", new SqlParameter("@bid", item.Id)).FirstOrDefault();

                    Detail detail = context.Details.SqlQuery("Select * from dbo.fn_GetDetail(@pcid, @pid)", new SqlParameter[]
                    {
                        new SqlParameter("@pcid", pcid),
                        new SqlParameter("@pid", batch.pid),
                    }).FirstOrDefault();

                    if (detail != null)
                    {
                        double quantity = item.Quantity + detail.quantity.Value;
                        context.Database.ExecuteSqlCommand("exec sp_Detail_Update @pcid, @pid, @quantity", new SqlParameter[]
                        {
                            new SqlParameter("@pcid", pcid),
                            new SqlParameter("@pid", batch.pid),
                            new SqlParameter("@quantity", quantity),
                        });
                    }
                    else
                    {
                        context.Database.ExecuteSqlCommand("exec sp_Detail_Insert @pcid, @pid, @quantity", new SqlParameter[]
                        {
                            new SqlParameter("@pcid", pcid),
                            new SqlParameter("@pid", batch.pid),
                            new SqlParameter("@quantity", item.Quantity),
                        });
                    }

                    context.Database.ExecuteSqlCommand("exec sp_Batch_Update @bid, @quantity", new SqlParameter[]
                    {
                        new SqlParameter("@bid", item.Id),
                        new SqlParameter("@quantity", item.Quantity),
                    });
                }
            }
            return Json(new { Result = true, Time = DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") });
        }
        #endregion

        #region Staff

        /// <summary>
        /// Return staff view
        /// </summary>
        /// <returns></returns>
        [Route("Admin/Staffs")]
        [HttpGet]
        public ActionResult Staff()
        {
            StaffViewModel viewModel = new StaffViewModel();
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                viewModel.Staffs = context.Staffs.SqlQuery("select * from dbo.fn_GetAllStaffs()").ToList();
                viewModel.AllStaffs = context.Staffs.SqlQuery("select * from dbo.fn_GetAllStaffsIncludingDeleted()").ToList();
            }
            viewModel.Staffs.Remove(viewModel.Staffs.Find(item => item.sid == "0"));
            return View(viewModel);

        }

        /// <summary>
        /// Return a specific staff from database to the view
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Route("Admin/Staff")]
        [HttpGet]
        public JsonResult GetStaff(string id)
        {
            Staff staff;
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                staff = context.Staffs.SqlQuery("select * from dbo.fn_GetStaffById(@id)", new SqlParameter("@id", id)).FirstOrDefault();
            }
            return Json(new
            {
                StaffName = staff.name,
                StaffId = staff.sid,
                Salary = staff.salary,
                PhoneNumber = staff.phone
            },
            JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Delete a staff in database
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Route("Admin/Staff/DeleteStaff")]
        [HttpPost]
        public JsonResult DeleteStaff(string id)
        {
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                try
                {
                    context.Database.ExecuteSqlCommand("exec sp_Staff_Delete @sid", new SqlParameter("@sid", id));
                    return Json(new { Result = true });
                }
                catch
                {
                    return Json(new { Result = false });
                }
            }

        }

        /// <summary>
        /// Add a staff to database
        /// </summary>
        /// <param name="staff"></param>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        [Route("Admin/Staff/AddStaff")]
        [HttpPost]
        public JsonResult AddStaff(Staff staff, string username, string password)
        {
            if (username == "admin")
            {
                return Json(new { Result = false, Message = "This username is already used" });
            }
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                List<string> usernameList = context.Database.SqlQuery<string>("select username from dbo.fn_GetAllStaffUsername()").ToList();
                if (usernameList.Contains(username))
                {
                    return Json(new { Result = false, Message = "This username is already been used" });
                }

                try
                {
                    context.Database.ExecuteSqlCommand("exec sp_Staff_Insert @sid, @name, @phone, @salary, @did", new SqlParameter[]
                    {
                        new SqlParameter("@sid", staff.sid),
                        new SqlParameter("@name", staff.name),
                        new SqlParameter("@phone", staff.phone),
                        new SqlParameter("@salary", staff.salary),
                        new SqlParameter("@did", "1")
                    });

                    context.Database.ExecuteSqlCommand("exec sp_StaffAccount_Insert @username, @password, @sid", new SqlParameter[]
                    {
                        new SqlParameter("@username", username),
                        new SqlParameter("@password", password),
                        new SqlParameter("@sid", staff.sid)
                    });

                    return Json(new { Result = true });
                }
                catch (SqlException e)
                {
                    return Json(new { Result = false, Message = e.Message });
                }

            }

        }

        /// <summary>
        /// Update changes of a staff to the database
        /// </summary>
        /// <param name="staff"></param>
        /// <returns></returns>
        [Route("Admin/Staff/EditStaff")]
        [HttpPost]
        public JsonResult EditStaff(Staff staff, string newPassword)
        {
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                try
                {
                    context.Database.ExecuteSqlCommand("exec sp_Staff_Update @sid, @name, @phone, @salary, @did", new SqlParameter[]
                    {
                        new SqlParameter("@sid", staff.sid),
                        new SqlParameter("@name", staff.name),
                        new SqlParameter("@phone", staff.phone),
                        new SqlParameter("@salary", staff.salary),
                        new SqlParameter("@did", "1")
                    });

                    if (newPassword != "")
                    {
                        context.Database.ExecuteSqlCommand("exec sp_StaffAccount_Update @newPassword, @sid", new SqlParameter[]
                        {
                            new SqlParameter("@newPassword", newPassword),
                            new SqlParameter("@sid", staff.sid)
                        });
                    }
                    return Json(new { Result = true });
                }
                catch
                {
                    return Json(new { Result = false });
                }
            }

        }

        /// <summary>
        /// Return staff view with a specific staff
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        [Route("Admin/Staffs/Search-{name}")]
        [HttpGet]
        public ActionResult SearchStaff(string name)
        {
            StaffViewModel viewModel = new StaffViewModel();
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {

                viewModel.Staffs = context.Staffs.SqlQuery("select * from dbo.fn_GetStaffByName(@name)", new SqlParameter("@name", $"%{name}%")).ToList();
                viewModel.AllStaffs = context.Staffs.SqlQuery("select * from dbo.fn_GetAllStaffsIncludingDeleted()").ToList();

                if (viewModel.Staffs.Count == 0)
                {
                    return View("Error");
                }
            }
            return View("Staff", viewModel);
        }

        #endregion

        #region Customer

        /// <summary>
        /// Return customer view
        /// </summary>
        /// <returns></returns>
        [Route("Admin/Customers")]
        [HttpGet]
        public ActionResult Customer()
        {
            CustomerViewModel viewModel = new CustomerViewModel();
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                viewModel.Customers = context.Customers.SqlQuery("select * from dbo.fn_GetAllCustomers()").ToList();
                viewModel.AllCustomers = context.Customers.SqlQuery("select * from dbo.fn_GetAllCustomersIncludingDeleted()").ToList();
            }
            return View(viewModel);

        }

        /// <summary>
        /// Return a specific customer from database to the view
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Route("Admin/Customer")]
        [HttpGet]
        public JsonResult GetCustomer(string id)
        {
            Customer customer;
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                customer = context.Customers.SqlQuery("select * from dbo.fn_GetCustomerById(@id)", new SqlParameter("@id", id)).FirstOrDefault();
            }
            return Json(new
            {
                CustomerName = customer.name,
                CustomerId = customer.cid,
                PhoneNumber = customer.phone,
                Points = customer.points
            },
            JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Delete a customer in database
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Route("Admin/Customer/DeleteCustomer")]
        [HttpPost]
        public JsonResult DeleteCustomer(string id)
        {
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                try
                {
                    context.Database.ExecuteSqlCommand("exec sp_Customer_Delete @cid", new SqlParameter("@cid", id));
                    return Json(new { Result = true });
                }
                catch
                {
                    return Json(new { Result = false });
                }
            }

        }

        /// <summary>
        /// Add a customer to database
        /// </summary>
        /// <param name="customer"></param>
        /// <returns></returns>
        [Route("Admin/Customer/AddCustomer")]
        [HttpPost]
        public JsonResult AddCustomer(Customer customer)
        {
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                try
                {
                    context.Database.ExecuteSqlCommand("exec sp_Customer_Insert @cid, @name, @phone, @points, @did", new SqlParameter[]
                    {
                        new SqlParameter("@cid", customer.cid),
                        new SqlParameter("@name", customer.name),
                        new SqlParameter("@phone", customer.phone),
                        new SqlParameter("@points", customer.points),
                        new SqlParameter("@did", "1")
                    });
                    return Json(new { Result = true });
                }
                catch
                {
                    return Json(new { Result = false });
                }
            }

        }

        /// <summary>
        /// Update changes of a customer to the database
        /// </summary>
        /// <param name="customer"></param>
        /// <returns></returns>
        [Route("Admin/Customer/EditCustomer")]
        [HttpPost]
        public JsonResult EditCustomer(Customer customer)
        {
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                try
                {
                    context.Database.ExecuteSqlCommand("exec sp_Customer_Update @cid, @name, @phone, @points, @did", new SqlParameter[]
                    {
                        new SqlParameter("@cid", customer.cid),
                        new SqlParameter("@name", customer.name),
                        new SqlParameter("@phone", customer.phone),
                        new SqlParameter("@points", customer.points),
                        new SqlParameter("@did", "1")
                    });
                    return Json(new { Result = true });
                }
                catch
                {
                    return Json(new { Result = false });
                }
            }

        }

        /// <summary>
        /// Return customer view with a specific customer
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        [Route("Admin/Customers/Search-{name}")]
        [HttpGet]
        public ActionResult SearchCustomer(string name)
        {
            CustomerViewModel viewModel = new CustomerViewModel();
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                viewModel.Customers = context.Customers.SqlQuery("select * from dbo.fn_GetCustomerByName(@name)", new SqlParameter("@name", $"%{name}%")).ToList();
                viewModel.AllCustomers = context.Customers.SqlQuery("select * from dbo.fn_GetAllCustomersIncludingDeleted()").ToList();
                if (viewModel.Customers.Count == 0)
                {
                    return View("Error");
                }
            }
            return View("Customer", viewModel);
        }
        #endregion
    }
}