
class Book
  attr_accessor :title, :id, :author, :status

  def initialize(title='', author='')
    @title = title
    @author = author
    @id = nil
    @status = 'available'
  end
  def check_out
    if @status == 'available'
      @status = 'checked_out'
      return true
    else
      return false
    end
  end
  def check_in
    if @status == 'checked_out'
      @status = 'available'
    end
  end
end

class Borrower
  attr_reader :name

  def initialize(name='')
    @name = name
  end
end

class Library
  attr_accessor :books, :id, :title, :author, :book_id, :borrower, :name, :status

  def initialize(name='')
    @books = []
    @borrowed_booklist = {}
  end
  def add_book(title, author)
    @title = title
    @author = author
  end
  def register_new_book(title,author)
    book = Book.new(title, author)
    book.id = rand(6**6).to_s.rjust(6,'0')
    @books.push(book)
  end
  def check_out_book(book_id, borrower)
    check_out_count = 0
    @borrowed_booklist.each do |key,value|
      if borrower.name == value.name
        check_out_count += 1
      end
    end

    @books.each do |book_searched|
      if (book_searched.status == 'checked_out' && book_searched.id == book_id) || check_out_count >= 2
        return nil
      elsif book_searched.id == book_id
        book_searched.status = 'checked_out'
        @borrowed_booklist[book_id] = borrower
        return book_searched
      else
        book_searched
      end
    end
  end
  def get_borrower(book_id)
    @borrowed_booklist[book_id].name
  end
  def check_in_book(book)
    if book.status == 'checked_out'
      @books.each do |book_searched|
        book.status = 'available'
        @borrowed_booklist.delete(book_id)
      end
    end
  end

  def available_books
    @books.select { |book|
      if book.status == 'available'
        book
      end
    }
  end

  def borrowed_books
    @books.select { |book| 
      if book.status == 'checked_out'
        book
      end
    }
  end
end