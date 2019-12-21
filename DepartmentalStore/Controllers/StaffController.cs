using DepartmentalStore.Viewmodels;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DepartmentalStore.Models;
using DepartmentalStore.App_Start;

namespace DepartmentalStore.Controllers
{
    [StaffAuthenticationFilter]
    public class StaffController : Controller
    {
        #region Dashboard
        [Route("Staff-{id}/Dashboard")]
        [HttpGet]
        public ActionResult Dashboard(string id)
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
        #endregion

        #region Customer

        /// <summary>
        /// Return customer view
        /// </summary>
        /// <returns></returns>
        [Route("Staff-{id}/Customers")]
        [HttpGet]
        public ActionResult Customer(string id)
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
        [Route("Staff/Customer")]
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
        [Route("Staff/Customer/DeleteCustomer")]
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
        [Route("Staff/Customer/AddCustomer")]
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
        [Route("Staff/Customer/EditCustomer")]
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
        [Route("Staff-{id}/Customers/Search-{name}")]
        [HttpGet]
        public ActionResult SearchCustomer(string id, string name)
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

        #region Purchasing

        /// <summary>
        /// Return purchasing view
        /// </summary>
        /// <returns></returns>
        [Route("Staff-{id}/Purchasing")]
        [HttpGet]
        public ActionResult Purchasing(string id)
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
        [Route("Staff/Purchasing/AddPurchase")]
        [HttpPost]
        public JsonResult AddPurchase(List<PurchaseItem> items, double totalValue, string cid)
        {
            using (DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                List<Purchase> purchases = context.Purchases.SqlQuery("Select * from dbo.fn_GetAllPurchases()").ToList();
                int pcid = purchases.Count + 1;
                string sid = TempData.Peek("StaffId").ToString();

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
            return Json(new { Result = true, Time = DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss"), StaffName = TempData.Peek("StaffName").ToString() });
        }
        #endregion

        #region Batch

        /// <summary>
        /// Return a product with batch id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Route("Staff/Batch-{id}/Product")]
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

        #endregion
    }
}