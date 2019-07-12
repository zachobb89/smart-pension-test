require 'spec_helper'
require './main'

RSpec.describe LogfileParser do
  let(:logfile_path) { 'spec/fixtures/webserver_sample.log' }
  subject { described_class.new(logfile_path) }

  describe 'initialized without logfile' do
    let(:logfile_path) { 'fake/path/to/file.log' }

    it 'raises an error', :skip_before do
      expect { subject }.to
      raise_error(RuntimeError, "No such file or directory @ #{logfile_path}")
    end
  end

  describe '#parse' do
    before { subject.parse }

    let(:expected_results) do
      {
        '/index' => ['444.701.448.104', '444.701.448.104', '126.318.035.038'],
        '/contact' => ['184.123.665.067'],
        '/about' => ['126.318.035.038'],
        '/about/2' => ['836.973.694.403'],
        '/home' => ['897.280.786.156', '715.156.286.412']
      }
    end

    it 'parses the data correctly' do
      expect(subject.entries).to eq(expected_results)
    end
  end

  describe '#most_views' do
    before { subject.parse }

    let(:expected_results) do
      {
        '/index' => 3,
        '/home' => 2,
        '/about' => 1,
        '/about/2' => 1,
        '/contact' => 1
      }
    end

    it 'returns the correct values' do
      expect(subject.most_views).to eq(expected_results)
    end
  end

  describe '#unique_views' do
    before { subject.parse }

    let(:expected_results) do
      {
        '/home' => 2,
        '/index' => 2,
        '/about' => 1,
        '/about/2' => 1,
        '/contact' => 1
      }
    end

    it 'returns the correct values' do
      expect(subject.unique_views).to eq(expected_results)
    end
  end
end

# describe "Vending Machine" do
#   let(:vending_machine) { VendingMachine.new }

#   #has an initial load of products
#   describe "#products" do
#     context "a new vending machine" do
#       it "should have an initial load of products" do
#         expect(vending_machine.shelf.products).not_to be_empty
#       end
#     end
#   end

#   #has an initial load of coins
#   describe "#coin_holder" do
#     context "a new vending machine" do
#       it "should have an initial load of change" do
#         expect(vending_machine.coin_holder.coins).not_to be_empty
#       end
#     end
#   end

#   #has no inserted coins to begin
#   describe "#inserted_pennies_total" do
#     context "a new vending machine" do
#       it "should have no inserted coins" do
#         expect(vending_machine.coin_holder.inserted_pennies_total).to eq(0)
#       end
#     end
#   end

#   #accepts inserted coins
#   describe "#insert" do
#     context "a new vending machine" do
#       it "should update the vending machine account balance (in pennies) " do
#         expect(vending_machine.coin_holder.inserted_pennies_total).to eq(0)
#         vending_machine.take_money("100")
#         expect(vending_machine.coin_holder.inserted_pennies_total).to eq(100)
#       end
#     end
#   end

#   #returns correct change
#   describe "#give_change" do
#     context "when money is inserted and a product is bought" do
#       it "ensures the correct denominations of change is deducted from the vending machine" do
#         vending_machine.take_money("50")
#         vending_machine.add_product("cake", 10, 10)
#         vending_machine.buy("cake")
#         expect(vending_machine.coin_holder.coins[:"20"][:qty]).to eq(98)
#         expect(vending_machine.coin_holder.inserted_pennies_total).to eq(0)
#       end
#     end
#   end

#   #reload products
#   describe "#refill_product" do
#     context "when an engineer reloads a product" do
#       it "increases the quantity of the selected product by the correct amount" do
#         e = Engineer.new(vending_machine)
#         vending_machine.add_product("cake", 10, 10)
#         e.refill_product("cake", 10)
#         expect(vending_machine.pick("cake").quantity).to eq(20)
#       end
#     end
#   end

#   #reload change
#   describe "#refill_change" do
#     context "when an engineer reloads change" do
#       it "increases the desired denomination by the correct amount" do
#         e = Engineer.new(vending_machine)
#         e.refill_change("100", 10)
#         expect(vending_machine.coin_holder.coins[:"100"][:qty]).to eq(110)
#       end
#     end
#   end

#   #add product
#   describe "#add_product" do
#     context "when a new product is added" do
#       it "adds the product to the shelf" do
#         vending_machine.add_product("cake", 10, 10)
#         expect(vending_machine.shelf.products.last.name).to eq("cake")
#       end
#     end
#   end

#   #correct product is returned / asks for more money / product is out of stock
#   describe "#buy" do
#     context "when enough money inserted" do
#       it "vends product" do
#         vending_machine.take_money("100")
#         vending_machine.add_product("cake", 10, 10)
#         expect(vending_machine.buy("cake")).to be_a(Product)
#       end
#     end

#     context "when not enough money is inserted" do
#       it "asks for more change" do
#         expect(vending_machine.buy"cola").to eq("Add more coins")
#       end
#     end
#     context "when the product is out of stock" do
#       it "states that the product is out of stock" do
#         vending_machine.take_money("100")
#         vending_machine.add_product("cake", 10, 0)
#         expect(vending_machine.buy"cake").to eq("Product out of stock")
#       end
#     end
#   end

# end
