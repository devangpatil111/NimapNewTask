using CrudOperation.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Data;

namespace CrudOperation.Controllers
{
    public class CategoryController : Controller
    {
        private static JsonResult JsonResult;
        private static string ConnectionString;
        List<Category> list = new List<Category>();
        Category category = new Category();
        public CategoryController()
        {

            GetAppSettingsFile();

        }
        public static void GetAppSettingsFile()
        {
            IConfiguration configuration = new ConfigurationBuilder()
              .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
              .Build();
            ConnectionString = configuration["ConnectionStrings:ConnString"];
        }
        public IActionResult Index()
        {
            list = GetList(-1);
            return View(list);
        }
        public IActionResult AddEdit(Int32 id)
        {
            list = GetList(id);
            if (list.Count > 0)
                category = list[0];
            return View("AddEdit", category);
        }
        public JsonResult Save(IFormCollection objFrom)
        {

            Int32 ID = Convert.ToInt32(objFrom["id"]);
            string Name = objFrom["name"];
            string SPName = "SaveCategory";
            using (SqlConnection sqlConnection = new SqlConnection(ConnectionString))
            {
                using (SqlCommand sqlCommand = new SqlCommand(SPName, sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@ID", ID);
                    sqlCommand.Parameters.AddWithValue("@Name", Name);
                    sqlCommand.ExecuteNonQuery();

                }
            }
            return Json(new { success = true, massage = "Category saved successfully!" });


        }



        public List<Category> GetList(Int32 id)
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConnectionString))
            {
                using (SqlCommand sqlCommand = new SqlCommand("GetCategory", sqlConnection))
                {
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@ID", id);
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    if (reader != null)
                    {
                        while (reader.Read())
                        {
                            Category category = new Category
                            {
                                ID = Convert.ToInt32(reader["ID"]),
                                CategoryName = reader["CategoryName"].ToString(),
                                StatusID = Convert.ToInt32(reader["StatusID"])
                            };
                            list.Add(category);
                        }
                    }
                }
            }
            return list;
        }
        public JsonResult Delete(Int32 id, int StatusId)
        {
            if (StatusId == 1)
                StatusId = 0;
            else
                StatusId = 1;

            string Query = "update Category set statusid = @StatusId where id = @ID";
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(Query, sqlConnection);
            sqlConnection.Open();
            sqlCommand.Parameters.AddWithValue("@ID", id);
            sqlCommand.Parameters.AddWithValue("@StatusId", StatusId);
            sqlCommand.ExecuteNonQuery();
            sqlConnection.Close();
            return Json(new { success = true, massage = "Deleted SuccessFully!" });
        }
    }
}
