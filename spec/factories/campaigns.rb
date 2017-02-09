FactoryGirl.define do
  factory :campaign do

	#hooks = Hook.all.to_a.map { |h| h.id } #TODO: Check this converts Hooks to an array of ID's
    #random_hook = hooks.at(Random.rand(0...(hooks.size))) # This is not tested

    name {Faker::Internet.name}
    #hook_identifier {Hook.where()}
    app_id nil
    email_list_id nil # TODO: Finish adding the campaign params
  end
end
