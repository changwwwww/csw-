package com.fh.api.dao;

import com.fh.api.po.Book;
import com.fh.po.Book;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookDao extends JpaRepository<Book,Integer> {
}
