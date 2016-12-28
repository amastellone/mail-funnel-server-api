MailFunnelServer::Application.routes.draw do

	# http://localhost:3001/API/
	mount API => '/'

	# require 'resque/server'
	# mount Resque::Server, at: '/jobs'

	# http://localhost:3001/RESOURCE

	resources :email_lists do # /email_lists/
		resources :emails # /email_lists/:email_list_id/emails/
	end

	resources :emails # /emails/
	resources :hooks # /hooks/

	resources :apps do # /apps/
		resources :jobs do # /apps/:app_id/jobs/
			resources :job_audits # /apps/:app_id/jobs/:job_id/job_audits/
			resources :email_lists do # /apps/:app_id/job_audits/
				resources :email # /apps/:app_id/jobs/:job_id/email_lists/:email_list_id/email/
			end
		end
		resources :email_lists do # /apps/:app_id/email_lists/
			resources :email
		end
		resources :job_audits # /apps/:app_id/job_audits/
		resources :emails

	end

	# TODO: Remove these routes /job_audits/ and /jobs/ - everything should be under /apps/
	resources :job_audits # /job_audits/
	resources :jobs # /jobs/

end
