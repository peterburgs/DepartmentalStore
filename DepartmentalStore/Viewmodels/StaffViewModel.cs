using DepartmentalStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DepartmentalStore.Viewmodels
{
    public class StaffViewModel
    {
        public List<Staff> Staffs { get; set; }
        public List<Staff> AllStaffs { get; set; }
    }
}