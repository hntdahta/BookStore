using System;
using System.Collections.Generic;
using System.Text;

namespace BookStore.Domain.Request.Book
{
    public class CreateBookRequest
    {
        public string BookName { get; set; }
        public string Author { get; set; }
        public int PagesNumber { get; set; }
        public int YearReleased { get; set; }
    }
}
