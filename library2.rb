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
  attr_reader :books, :borrower

  def initialize(name="APL")
    @name = name
    @books = []
    @borrowed_books = {}
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author)

    #create randomized ID, convert to string to allowed right-justification of 6 characters
    #then convert back to integer
    new_book.id = rand(6**6).to_s.rjust(6,'0').to_i
    @books << new_book
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    check_out_count = 0
    book = @books.find{ |x| x.id == book_id }
    
    if check_out_count > 3
      return nil
    end

    if book.status == 'available'
      book.check_out
      check_out_count += 1
      @borrowed_books[book_id] = borrower
      book
    end
    
  end

  def get_borrower(book_id)
    @borrowed_books[book_id].name
  end

  def check_in_book(book)
    if book.status == 'checked_out'
      book.check_in
    end
  end

  def available_books
    @books.select{ |x| x.status == 'available'}
  end

  def borrowed_books
    @books.select{ |x| x.status == 'checked_out'}
  end
end