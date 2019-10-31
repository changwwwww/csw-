package com.fh.api.biz;

import com.fh.api.commons.Page;
import com.fh.api.commons.ServerResponse;
import com.fh.api.po.Book;
import com.fh.commons.DataTable;
import com.fh.commons.Page;
import com.fh.commons.ServerResponse;
import com.fh.po.Book;

public interface BookService {
    ServerResponse queryBook();

    void addBook(Book book);

    void delBook(Integer id);

    Book showBook(Integer id);

    Book updateBook(Book book);

    ServerResponse queryBooks(Page page);
}
