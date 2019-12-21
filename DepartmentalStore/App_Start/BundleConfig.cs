using System.Web;
using System.Web.Optimization;

namespace DepartmentalStore
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js",
                        "~/Scripts/jquery.colorbox-min.js",
                        "~/Scripts/jquery-ui.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at https://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/popper.min.js",
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/bootstrap.bundle.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/jquery-ui.css",
                      "~/Content/bootstrap.css"));

            bundles.Add(new ScriptBundle("~/bundles/login/js").Include(
                    "~/Resources/Login/js/chart.js",
                    "~/Resources/Login/js/main.js",
                    "~/Resources/Login/js/misc.js",
                    "~/Resources/Login/js/off-canvas.js",
                    "~/Resources/Login/js/vendor.bundle.addons.js",
                    "~/Resources/Login/js/vendor.bundle.base.js"));

            bundles.Add(new StyleBundle("~/bundles/login/css").Include(
                    "~/Resources/Login/css/materialdesignicons.css",
                    "~/Resources/Login/css/ionicons.css",
                    "~/Resources/Login/css/typicons.css",
                    "~/Resources/Login/css/flag-icon.min.css",
                    "~/Resources/Login/css/vendor.bundle.base.css",
                    "~/Resources/Login/css/vendor.bundle.addons.css",
                    "~/Resources/Login/css/style.css",
                    "~/Resources/Login/css/custom.css"));

            #region Admin

            bundles.Add(new StyleBundle("~/bundles/Admin/Layout/css").Include(
                    "~/Resources/Admin/Layout/css/footer.css",
                    "~/Resources/Admin/Layout/css/style.css",
                    "~/Resources/Admin/Layout/css/paper-dashboard.css"));

            bundles.Add(new ScriptBundle("~/bundles/Admin/Layout/js").Include(
                    "~/Resources/Admin/Layout/js/all.js",
                    "~/Resources/Admin/Layout/js/base.min.js",
                    "~/Resources/Admin/Layout/js/plugins.min.js",
                    "~/Resources/Admin/Layout/js/main.js"));

            bundles.Add(new StyleBundle("~/bundles/Admin/Dashboard/css").Include(
                    "~/Resources/Admin/Dashboard/css/style.css",
                    "~/Resources/Admin/Dashboard/css/popup.css"));

            bundles.Add(new ScriptBundle("~/bundles/Admin/Dashboard/js").Include(
                    "~/Resources/Admin/Dashboard/js/main.js"));

            bundles.Add(new StyleBundle("~/bundles/Admin/Product/css").Include(
                    "~/Resources/Admin/Product/css/style.css"));

            bundles.Add(new ScriptBundle("~/bundles/Admin/Product/js").Include(
                    "~/Resources/Admin/Product/js/main.js"));

            bundles.Add(new StyleBundle("~/bundles/Admin/ProductDetail/css").Include(
                    "~/Resources/Admin/ProductDetail/css/style.css"));

            bundles.Add(new ScriptBundle("~/bundles/Admin/ProductDetail/js").Include(
                    "~/Resources/Admin/ProductDetail/js/main.js"));

            bundles.Add(new StyleBundle("~/bundles/Admin/Purchasing/css").Include(
                    "~/Resources/Admin/Purchasing/css/style.css"));

            bundles.Add(new ScriptBundle("~/bundles/Admin/Purchasing/js").Include(
                    "~/Resources/Admin/Purchasing/js/main.js"));

            bundles.Add(new StyleBundle("~/bundles/Admin/Staff/css").Include(
                    "~/Resources/Admin/Staff/css/style.css"));

            bundles.Add(new ScriptBundle("~/bundles/Admin/Staff/js").Include(
                    "~/Resources/Admin/Staff/js/main.js"));

            bundles.Add(new StyleBundle("~/bundles/Admin/Customer/css").Include(
                    "~/Resources/Admin/Customer/css/style.css"));

            bundles.Add(new ScriptBundle("~/bundles/Admin/Customer/js").Include(
                    "~/Resources/Admin/Customer/js/main.js"));

            #endregion

            #region Staff


            bundles.Add(new StyleBundle("~/bundles/Staff/Layout/css").Include(
                "~/Resources/Staff/Layout/css/footer.css",
                "~/Resources/Staff/Layout/css/style.css",
                "~/Resources/Staff/Layout/css/paper-dashboard.css"));

            bundles.Add(new ScriptBundle("~/bundles/Staff/Layout/js").Include(
                "~/Resources/Staff/Layout/js/all.js",
                "~/Resources/Staff/Layout/js/base.min.js",
                "~/Resources/Staff/Layout/js/plugins.min.js",
                "~/Resources/Staff/Layout/js/main.js"));

            bundles.Add(new StyleBundle("~/bundles/Staff/Dashboard/css").Include(
                "~/Resources/Staff/Dashboard/css/style.css",
                "~/Resources/Staff/Dashboard/css/popup.css"));

            bundles.Add(new ScriptBundle("~/bundles/Staff/Dashboard/js").Include(
                "~/Resources/Staff/Dashboard/js/main.js"));

            bundles.Add(new StyleBundle("~/bundles/Staff/Purchasing/css").Include(
                "~/Resources/Staff/Purchasing/css/style.css"));

            bundles.Add(new ScriptBundle("~/bundles/Staff/Purchasing/js").Include(
                "~/Resources/Staff/Purchasing/js/main.js"));

            bundles.Add(new StyleBundle("~/bundles/Staff/Customer/css").Include(
                "~/Resources/Staff/Customer/css/style.css"));

            bundles.Add(new ScriptBundle("~/bundles/Staff/Customer/js").Include(
                "~/Resources/Staff/Customer/js/main.js"));

            #endregion

            #region Guest
            bundles.Add(new StyleBundle("~/bundles/Guest/Layout/css").Include(
                    "~/Resources/Guest/Layout/css/footer.css",
                    "~/Resources/Guest/Layout/css/style.css",
                    "~/Resources/Guest/Layout/css/paper-dashboard.css"));

            bundles.Add(new ScriptBundle("~/bundles/Guest/Layout/js").Include(
                    "~/Resources/Guest/Layout/js/all.js",
                    "~/Resources/Guest/Layout/js/base.min.js",
                    "~/Resources/Guest/Layout/js/plugins.min.js",
                    "~/Resources/Guest/Layout/js/main.js"));

            bundles.Add(new StyleBundle("~/bundles/Guest/Dashboard/css").Include(
                    "~/Resources/Guest/Dashboard/css/style.css",
                    "~/Resources/Guest/Dashboard/css/popup.css"));

            bundles.Add(new ScriptBundle("~/bundles/Guest/Dashboard/js").Include(
                    "~/Resources/Guest/Dashboard/js/main.js"));
            #endregion
        }
    }
}
