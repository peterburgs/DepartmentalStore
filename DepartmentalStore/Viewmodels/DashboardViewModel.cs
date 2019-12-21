using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DepartmentalStore.Viewmodels
{
    public class DashboardViewModel
    {
        private Nullable<double> dailyIncome;
        public int TotalProducts { get; set; }

        public int TotalStaffs { get; set; }

        public int TotalCustomers { get; set; }

        public Models.DashBoardMonthlyIncome MonthlyIncome { get; set; }
        public double? DailyIncome { get => dailyIncome == null ? 0 : dailyIncome; set => dailyIncome = value; }
    }
}