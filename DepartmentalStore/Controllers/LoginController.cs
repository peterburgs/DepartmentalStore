using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DepartmentalStore.Models;

namespace DepartmentalStore.Controllers
{
    public class LoginController : Controller
    {
        [AllowAnonymous]
        // GET: Login
        public ActionResult Index()
        {
            Session["LoginAdmin"] = false;
            Session["LoginStaff"] = false;
            return View();
        }

        [HttpPost]
        [Route("Login/OnPost")]
        public JsonResult OnPost(string username, string password)
        {
            bool isAdminLogin;
            string staffId;
            Staff staff;
            using(DepartmentalStoreManagementEntities context = new DepartmentalStoreManagementEntities())
            {
                isAdminLogin = context.Database.SqlQuery<bool>("Select dbo.fn_IsAdminLogin(@username, @password)", new SqlParameter("@username", username), new SqlParameter("@password", password)).FirstOrDefault();
                staffId = context.Database.SqlQuery<string>("Select dbo.fn_IsStaffLogin(@username, @password)", new SqlParameter("@username", username), new SqlParameter("@password", password)).FirstOrDefault();
                if (staffId != null)
                {
                    staff = context.Staffs.SqlQuery("Select * from dbo.fn_GetStaffById(@sid)",
                        new SqlParameter("@sid", staffId)).FirstOrDefault();
                    TempData["StaffName"] = staff.name;
                    TempData["StaffId"] = staff.sid;
                }
            }
            if(isAdminLogin)
            {
                Session["LoginAdmin"] = true;
                return Json(new { Result = true, Admin = true, Staff = false, StaffId = "" });
            }
            else if(staffId != null)
            {
                Session["LoginStaff"] = true;
                return Json(new { Result = true, Admin = false, Staff = true, StaffId = staffId });
            }
            Session["LoginAdmin"] = false;
            Session["LoginStaff"] = false;
            return Json(new { Result = false});
        }
    }
}