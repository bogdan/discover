# Discover
rspec matcher to test named\_scope or scoped

## Installation

Add this line to your application's Gemfile:

    gem 'discover'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install discover

## Usage

What do we expect from the custom finder? We expect that it should find assets A, B, C and should not find assets D, E, F. And sometimes the order is important: it should find A, B C with exact order. With respect to let rspec feature let's take an example: Product has and belongs to many categories. We need to have a scope to filter products within the specified category:

``` ruby
    describe '.by_category_id' do
      let(:given_category) do
        Factory.create(:given_category)
      end


      let(:product_in_given_category) do
        Factory.create(
          :product,
          :categories => [category]
        )
      end

      let(:product_not_in_given_category) do
        Factory.create(
          :product,
          :categories => [Factory.create(:category)]
        )
      end

      # This might be tricky to redefine subject as the finder result
      # but in this way we can delegate the matcher to subject and
      # avoid writing test descriptions.
      subject { Product.by_category_id(given_category.id) }

      it { should discover(product_in_given_category) }
      it { should_not discover(product_not_in_given_category) }

    end
```
Factory girl was used in this example because factories kickass when we test finders. As you can see the example has a perfect readability with no one line of plain English text. I didn't include the description in my examples but you can easily make them if they make sense for you.
Note: Be aware of the lazy loading of your finder. ``let`` is initialized lazy too. You should make sure it is called before the actual query to the database. If you don't want to care about lazy loading their is ``let!`` method that could be easily copy-pasted from Rspec 2.0. Unlike ``let`` it doesn't have lazy initialization:

``` ruby
def let!(name, &block)
  let(name, &block)
  before { __send__(name) }
end
```

### Testing sort order

If the ordering is done in non-trivial way let's ``discover.with_exact_order``.
``` ruby
describe "#most_commented named scope" do
  let(:uncommented_post) { Factory.create(:post)}
  let!(:less_commented_post) { Factory.create(:post, :comments => [Factory.build(:comment)])}
  let!(:more_commented_post) {
    Factory.create(:post, :comments => [Factory.build(:comment), Factory.build(:comment)])}
  }

 subject { described_class.most_commented }
 it {should discover(more_commented_post, less_commented_post).with_exact_order }
 it {should_not discover(uncommented_post) }
end
```
Be careful with default order. MySQL and Postgres sort objects as they were created by default. That is why generate objects in reverse order e.g. ``less_commented_post`` before ``more_commented_post`` is important to make sure that ordering is your code behavior rather than default db behavior.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
