module Msf
module Ui
module Gtk2

###
#
# Handles events of various types that are sent from the framework.
#
###
module FrameworkEventManager

	include Msf::SessionEvent

	#
	# Subscribes to the framework as a subscriber of various events.
	#
	def register_event_handlers
		framework.events.add_session_subscriber(self)
	end

	#
	# Unsubscribes from the framework.
	#
	def deregister_event_handlers
		framework.events.remove_session_subscriber(self)
	end

	#
	# Called when a session is registered with the framework.
	#
	def on_session_open(session)
	
		Msf::Ui::Gtk2::Stream::Session.new($gtk2driver.session_tree, session)
		
		if (Msf::Logging.session_logging_enabled? == true)
			Msf::Logging.start_session_log(session)
		end	
	end

	#
	# Called when a session is closed and removed from the framework.
	#
	def on_session_close(session)
	
		$gtk2driver.session_tree.remove_session(session)

		# If logging had been enabled for this session, stop it now.
		Msf::Logging::stop_session_log(session)
		
	end

end

end
end
end
