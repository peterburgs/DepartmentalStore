using DepartmentalStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DepartmentalStore.Viewmodels
{
    public class ProductDetailViewModel
    {
        public Product Product { get; set; }
        public List<ImageReference> ImageReferences { get; set; }
        public Batch Batch { get; set; }
    }
}