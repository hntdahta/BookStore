using BookStore.BAL.Interface;
using BookStore.DAL.Interface;
using BookStore.Domain.Request.Book;
using BookStore.Domain.Respone.Book;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace BookStore.BAL
{
    public class BookService : IBookService
    {
        private readonly IBookRepository bookRepository;
        public BookService(IBookRepository bookRepository)
        {
            this.bookRepository = bookRepository;
        }
        public async Task<CreateBookResult> CreateBook(CreateBookRequest request)
        {
            return await bookRepository.CreateBook(request);
        }

        public async Task<DeleteBookResult> DeleteBook(DeleteBookRequest request)
        {
            return await bookRepository.DeleteBook(request);
        }

        public async Task<GetBookDetailResult> GetBookDetail(GetBookDetailRequest request)
        {
            return await bookRepository.GetBookDetail(request);
        }

        public async Task<IEnumerable<Book>> Gets()
        {
            return await bookRepository.Gets();
        }
    }
}
