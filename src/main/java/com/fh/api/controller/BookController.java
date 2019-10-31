package com.fh.api.controller;

import com.fh.api.po.Book;
import com.fh.biz.BookService;
import com.fh.commons.DataTable;
import com.fh.commons.Page;
import com.fh.commons.ServerResponse;
import com.fh.po.Book;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/book")
public class BookController {

    @Resource(name = "bookService")
    private BookService bookService;

    @RequestMapping("/toList")
    public String toList(){

        return "book";
    }

    @RequestMapping("/queryBook")
    @ResponseBody
    public ServerResponse queryBook(){
        return    bookService.queryBook();
    }

    @RequestMapping("/queryBooks")
    @ResponseBody
    public ServerResponse queryBooks(Page page){
        return bookService.queryBooks(page);
    }

    @RequestMapping("/addBook")
    @ResponseBody
    public ServerResponse addBook(Book book){
        bookService.addBook(book);
        return  ServerResponse.success();
    }

    @RequestMapping("/delBook")
    @ResponseBody
    public ServerResponse delBook(Integer id){
        bookService.delBook(id);
        return  ServerResponse.success();
    }

    @RequestMapping("/showBook")
    @ResponseBody
    public ServerResponse showBook(Integer id){
     Book book= bookService.showBook(id);
        return  ServerResponse.success(book);
    }

    @RequestMapping("/updateBook")
    @ResponseBody
    public  ServerResponse updateBook(Book book){
     Book books=  bookService.updateBook(book);

        return  ServerResponse.success(books);
    }

}
