class Book
  attr_reader :title, :author
  attr_accessor :id, :status

  def initialize(title, author)
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
      return true
    else
      return false
    end
  end
end

class Borrower
  attr_reader :books, :name, :title, :author

  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :books

  def initialize(name="APL")
    @name = name
    @books = []
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author)
    new_book.id = rand(6**6).to_s.rjust(6,'0').to_i
    @books << new_book
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    if @books.detect{ |x| x == book_id } != nil
      book.checkout
    end

  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end