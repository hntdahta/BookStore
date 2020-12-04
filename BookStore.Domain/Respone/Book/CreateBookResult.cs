using System;
using System.Collections.Generic;
using System.Text;

namespace BookStore.Domain.Respone.Book
{
    public class CreateBookResult
    {
        public int BookId { get; set; }
        public string Message { get; set; }
    }
}
