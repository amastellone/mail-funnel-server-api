#SERVER - Seeds.rb


# Generate Default Data
execute_initial = true
if execute_initial == true

	test_app         = App.create(name: "bluehelmet-client-rspec-test-app")

	app_create       = App.create(name: "bluehelmet-dev")
	app              = app_create.id

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


# Bluehelmet App Install

# Default Email-List + Generate Test Emails
defaultlist = EmailList.create(name:        "Default",
                               description: "The default Mail-Funnel email list",
                               app_id:      app);
$y = 0
until $y > Random.rand(7...15) do
	email = Email.create(email:         Faker::Internet.email,
	                     name:          Faker::Internet.name,
	                     app_id:        app,
	                     email_list_id: defaultlist.id);
	puts defaultlist.name.to_s + ": Email Created " + email.email.to_s
	$y += 1
end

# Generate All Other Test Data
$x = 0
until $x > Random.rand(7...15) do
	list = EmailList.create(name:        "Email List some Name " + $x.to_s,
	                        description: "A Mail-Funnel email list",
	                        app_id:      app)

	$y = 0
	until $y > Random.rand(7...15) do
		email = Email.create(email:         Faker::Internet.email,
		                     name:          Faker::Internet.name,
		                     app_id:        app,
		                     email_list_id: list.id)
		puts list.name.to_s + ": Email Created " + email.email.to_s
		$y += 1
	end
	$x += 1
end


# GENERATE TEST DATA
generate_extra_data = true
if generate_extra_data == true
	puts 'GENERATING EXTRA SEED DATA:'

	$x = 0
	while $x < 20 do
		app = App.create(name: "App-Name " + $x.to_s)

		$y = 0
		while $y < 5 do
			list = EmailList.create(name:        "Main List " + $y.to_s,
			                        description: "This is a great email list",
			                        app_id:      app.id)

			puts "Created List " + list.name.to_s

			$z = 0
			while $z > Random.rand(3...15) do
				email = Email.create(email:         Faker::Internet.email,
				                     name:          Faker::Internet.name,
				                     app_id:        app.id,
				                     email_list_id: list.id)
				puts list.name.to_s + ": Email Created " + email.email.to_s
				$z += 1
			end

			$y +=1
		end

		$x +=1
	end

	$x = 0
	while $x < Random.rand(10...30) do
		job = Job.create(frequency:           "execute_once",
		                 execute_time:        "1330",
		                 subject:             "Email subject",
		                 content:             "Email Contents",
		                 app_id:              app.id,
		                 campaign_identifier: Hook.offset(rand(Hook.count)).first.id,
		                 hook_identifier:     Hook.offset(rand(Hook.count)).first.id,
		                 executed:            false,
		                 email_list_id:       EmailList.offset(rand(EmailList.count)).first
		)
		puts "Job Created for " + job.hook_identifier.to_s
		$x += 1
	end
end
