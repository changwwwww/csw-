package com.fh.api.biz;


import com.fh.api.commons.DataTable;
import com.fh.api.commons.ServerResponse;
import com.fh.api.dao.BookDao;
import com.fh.api.po.Book;
import com.fh.commons.DataTable;
import com.fh.commons.ServerResponse;
import com.fh.dao.BookDao;
import com.fh.po.Book;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

@Service("bookService")
public class BookServiceImpl implements BookService {

    @Resource
    private BookDao bookDao;

    @Override
    public ServerResponse queryBook() {
        List<Book> bookList = bookDao.findAll();
        return ServerResponse.success(bookList);
    }

    @Override
    public void addBook(Book book) {
        bookDao.save(book);
    }

    @Override
    public void delBook(Integer id) {
        bookDao.delete(id);
    }

    @Override
    public Book showBook(Integer id) {

        return bookDao.findOne(id);
    }

    @Override
    public Book updateBook(Book book) {

        return bookDao.saveAndFlush(book);
    }

    @Override
    public ServerResponse queryBooks(com.fh.api.commons.Page page) {
        PageRequest pageable=new PageRequest(page.getStart()/page.getLength(),page.getLength());
        Page<Book> books = bookDao.findAll(pageable);
        List<Book> list =books.getContent();
        long count =books.getTotalElements();
        DataTable dataTable=new DataTable(page.getDraw(),count,count,list);
        return ServerResponse.success(dataTable);

    }
}
