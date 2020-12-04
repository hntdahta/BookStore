using BookStore.Domain.Request.Book;
using BookStore.Domain.Respone.Book;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace BookStore.BAL.Interface
{
    public interface IBookService
    {
        Task<IEnumerable<Book>> Gets();
        Task<GetBookDetailResult> GetBookDetail(GetBookDetailRequest request);
        Task<CreateBookResult> CreateBook(CreateBookRequest request);
        Task<DeleteBookResult> DeleteBook(DeleteBookRequest request);
    }
}
