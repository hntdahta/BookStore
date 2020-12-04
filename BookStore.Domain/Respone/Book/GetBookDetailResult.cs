using System;
using System.Collections.Generic;
using System.Text;

namespace BookStore.Domain.Respone.Book
{
    public class GetBookDetailResult
    {
        public int BookId { get; set; }
        public string BookName { get; set; }
        public string Author { get; set; }
        public int PagesNumber { get; set; }
        public int YearReleased { get; set; }

    }
}
