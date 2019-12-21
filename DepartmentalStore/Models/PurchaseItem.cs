using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace DepartmentalStore.Models
{
    public class PurchaseItem
    {
        [DisplayName("id")]
        public string Id { get; set; }

        [DisplayName("name")]
        public string Name { get; set; }

        [DisplayName("rating")]
        public double Rating { get; set; }

        [DisplayName("quantity")]
        public double Quantity { get; set; }

        [DisplayName("value")]
        public double Value { get; set; }
    }
}