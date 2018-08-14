require('pry-byebug')
require_relative('models/bounty.rb')

bounty1 = Bounty.new({
  'name' => 'Bob Smith',
  'species' => 'Human',
  'fav_weapon' => 'Sword',
  'value' => '100'
})

bounty2 = Bounty.new({
  'name' => 'Delilah Blue',
  'species' => 'Neptunian',
  'fav_weapon' => 'Heirloom of the Burning Sun',
  'value' => '500'
})


bounty1.save
bounty2.save
#bounty1.delete

binding.pry
nil
