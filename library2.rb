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
      true
    else
      false
    end
  end
  def check_in
    if @status == 'checked_out'
      @status = 'available'
      true
    else
      false
    end
  end
end

class Borrower
  attr_reader :books, :title, :author
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :books, :borrower, :borrowed_books, :borrower_book_count

  def initialize(name="APL")
    @name = name
    @books = []
    @borrowed_books = {}
    @borrower_book_count = Hash.new { |hash, key| hash[key] = 0 }
    # For more info on the line above, see third method on most voted answer:
    # http://stackoverflow.com/questions/2990812/initializing-hashes
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author)

    # create randomized ID, convert to string to allowed right-justification of 6 characters
    # then convert back to integer but dupes may occur...
    # new_book.id = rand(6**6).to_s.rjust(6,'0').to_i
    # Can also use "object.id" method

    new_book.id = rand(10000) + Time.now.to_i
    @books << new_book
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    book = @books.find{ |x| x.id == book_id }
    @borrower_book_count[borrower] += 1
    
    if book.status == 'available' and @borrower_book_count[borrower] < 3
      book.check_out
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
    @books.select{ |x| x.status == 'available'} # ".select" alias ".find_all"
  end

  def borrowed_books
    @books.select{ |x| x.status == 'checked_out'}
  end
end