module RocketJobMissionControl
  module JobsHelper
    def job_icon(job)
      state =
        if job.scheduled?
          :scheduled
        else
          job.state
        end
      state_icon(state)
    end

    def job_counts_by_state(state)
      state = 'queued_now' if state == 'queued'
      RocketJob::Job.counts_by_state.fetch(state.downcase.to_sym, 0)
    end

    def job_action_link(action, path, http_method=:get)
      link_to(
        action,
        path,
        method: http_method,
        class:  'btn btn-default',
        data:   {confirm: t(:confirm, scope: [:job, :action], action: action)}
      )
    end

    def job_states
      @job_states ||= RocketJob::Job.aasm.states.map { |state| state.name.to_s }
    end

    def job_selected_class(job, selected_job)
      if selected_job.present? && job.id == selected_job.id
        'selected'
      else
        ''
      end
    end

  end
end
