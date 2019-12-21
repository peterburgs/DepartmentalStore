using DepartmentalStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DepartmentalStore.Viewmodels
{
    public class CustomerViewModel
    {
        public List<Customer> Customers { get; set; }
        public List<Customer> AllCustomers { get; set; }
    }
}