using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DepartmentalStore.Models;
using DepartmentalStore.Viewmodels;

namespace DepartmentalStore.Controllers
{
    public class GuestController : Controller
    {
        #region Dashboard
        [Route("Guest/Dashboard")]
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
        #endregion
    }
}