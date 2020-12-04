using BookStore.DAL.Interface;
using BookStore.Domain.Request.Book;
using BookStore.Domain.Respone.Book;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Threading.Tasks;

namespace BookStore.DAL
{
    public class BookRepository : BaseRepository, IBookRepository
    {
        public async Task<CreateBookResult> CreateBook(CreateBookRequest request)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@BookName", request.BookName);
                parameters.Add("@Author", request.Author);
                parameters.Add("@PagesNumber", request.PagesNumber);
                parameters.Add("@YearReleased", request.YearReleased);
                return await SqlMapper.QueryFirstOrDefaultAsync<CreateBookResult>(cnn: connect,
                                                    sql: "sp_CreateBook",
                                                    param: parameters,
                                                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public async Task<DeleteBookResult> DeleteBook(DeleteBookRequest request)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@BookId", request.BookId);
                return await SqlMapper.QueryFirstOrDefaultAsync<DeleteBookResult>(cnn: connect,
                                                    sql: "sp_DeleteBook",
                                                    param: parameters,
                                                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public async Task<GetBookDetailResult> GetBookDetail(GetBookDetailRequest request)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@BookId", request.BookId);
                return await SqlMapper.QueryFirstOrDefaultAsync<GetBookDetailResult>(cnn: connect,
                                                    sql: "sp_GetDetailBook",
                                                    param: parameters,
                                                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public async Task<IEnumerable<Book>> Gets()
        {
            return await SqlMapper.QueryAsync<Book>(cnn: connect,
                                    sql: "sp_GetBooks",
                                    commandType: CommandType.StoredProcedure);
        }
    }
}
