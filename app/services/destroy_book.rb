class DestroyBook
    Result = Struct.new(:success?, :book, keyword_init: true)

    def initialize(book)
        @book = book
    end

    def perform
        destroyed_book = book.destroy!

        Result.new({ success?: true, book: destroyed_book })
    end

    private 

    attr_accessor :book
end