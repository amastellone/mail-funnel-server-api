#Seeding


execute_initial = true
if execute_initial == true

	app_create       = App.create(name: "bluehelmet-dev")
	app              = app_create.id

	# job1 = Job.where()

	# api_key: ENV['API_KEY'],
	# api_secret: ENV['API_SECRET'],
	# );

	# Configs.create(name: "")

	# Checkout
	cart_create_hook = Hook.create(name: 'Cart / Create', identifier: 'cart_create');
	cart_update_hook = Hook.create(name: 'Cart / Update', identifier: 'cart_update');
	cart_abandon_hook    = Hook.create(name: 'Cart / Abandon', identifier: 'cart_abandon');

	# Checkout
	checkout_create_hook = Hook.create(name: 'Checkout / Create', identifier: 'checkout_create');
	checkout_update_hook = Hook.create(name: 'Checkout / Update', identifier: 'checkout_update');

	# Order
	order_create_hook    = Hook.create(name: 'Order / Create', identifier: 'order_create');
	order_update_hook = Hook.create(name: 'Order / Update', identifier: 'order_update');

else
	app_create = App.where(name: "bluehelmet-dev").first
	app        = app_create.id
end


# Generate default Email_List
defaultlist = EmailList.create(name:        "Default",
                               description: "The default Mail-Funnel email list",
                               app_id:      app);


# until $x > Random.rand(3...15) do
email       = Email.create(email:         Faker::Internet.email,
                           name:          Faker::Internet.name,
                           app_id:        app,
                           email_list_id: defaultlist.id);
puts defaultlist.name.to_s + ": Email Created " + email.email.to_s
# end


# GENERATE TEST DATA
generate_extra_data = true
if generate_extra_data == true

	puts 'GENERATING EXTRA SEED DATA:'

	$x = 0
	while $x < 5 do
		list = EmailList.create(name:        "Main List " + $x.to_s,
		                        description: "This is a great email list",
		                        app_id:      app);

		puts "Created List " + list.name.to_s
		$y = 0
		while $y > Random.rand(3...15) do
			email = Email.create(email:         Faker::Internet.email,
			                     name:          Faker::Internet.name,
			                     app_id:        app,
			                     email_list_id: list.id);
			puts list.name.to_s + ": Email Created " + email.email.to_s
			$y += 1
		end
		$x +=1
	end

	thislist = EmailList.all.first
	$x       = 0
	while $x < Random.rand(5...20) do
		job = Job.create(frequency:           "execute_once",
		                 execute_time:        "1330",
		                 subject:             "Email subject",
		                 content:             "Email Contents",
		                 app_id:              app,
		                 campaign_identifier: Hook.offset(rand(Hook.count)).first.id,
		                 hook_identifier:     Hook.offset(rand(Hook.count)).first.id,
		                 executed:            false,
		                 email_list_id:       EmailList.offset(rand(EmailList.count)).first
		)
		puts "Job Created for " + job.hook_identifier.to_s
		$x += 1
	end
end
