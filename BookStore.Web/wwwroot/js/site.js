var Book = {} || Book;

Book.tbBook = function () {
    $.ajax({
        url: 'https://localhost:44382/api/book/gets',
        method: 'GET',
        contentType: 'JSON',
        success: function (data) {
            $.each(data, function (i, v) {
                $('#tbBook>tbody').append(`<tr>
                                            <td>${v.bookId}</td>
                                            <td>${v.bookName}</td>
                                        </tr>`);
            })

        }
    });
}

Book.init = function () {
    Book.tbBook();
}

$(document).ready(function () {
    Book.init();
});