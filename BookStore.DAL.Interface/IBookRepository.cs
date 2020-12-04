using BookStore.Domain.Request.Book;
using BookStore.Domain.Respone.Book;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace BookStore.DAL.Interface
{
    public interface IBookRepository
    {
        Task<IEnumerable<Book>> Gets();
        Task<GetBookDetailResult> GetBookDetail(GetBookDetailRequest request);
        Task<CreateBookResult> CreateBook(CreateBookRequest request);
        Task<DeleteBookResult> DeleteBook(DeleteBookRequest request);
    }
}
