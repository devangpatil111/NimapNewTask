namespace CrudOperation.Models
{
    public class Product
    {
        public Int64 ID { get; set; }

        public Int64 CategoryId { get; set; }
        public string Name { get; set; }
        public int StatusID { get; set; }
        public string CategoryName { get; set; }
    }
}
