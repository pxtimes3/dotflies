#taskwarrior.nix
{
  pkgs,
  config,
  ...
}:
{
	programs.taskwarrior = {
    	enable = true;
    	config.default = ''
    		## https://gist.github.com/djmitche/dd7c9f257306e6b8957759c4d5265cc9
    		## 
    		data.location=~/.config/taskdata

			color=on
			color.header=rgb031
			color.footnote=rgb031
			color.error=rgb031
			color.debug=rgb031

			color.summary.bar=white on rgb030
			color.summary.background=white on color0

			color.history.add=color0 on rgb010
			color.history.done=color0 on rgb030
			color.history.delete=color0 on rgb050

			color.burndown.pending=on rgb010
			color.burndown.started=on rgb030
			color.burndown.done=on gray4

			color.sync.added=gray4
			color.sync.changed=rgb030
			color.sync.rejected=red

			color.undo.before=rgb031
			color.undo.after=rgb053

			color.calendar.today=color0 on rgb151
			color.calendar.due=color0 on color249
			color.calendar.due.today=color0 on color225
			color.calendar.overdue=color0 on color255
			color.calendar.weekend=on color235
			color.calendar.holiday=rgb151 on rgb020
			color.calendar.weeknumber=rgb010

			color.recurring=rgb151
			color.overdue=color255
			color.due.today=color252
			color.due=color249
			color.active=bold white on rgb012
			color.uda.priority.none=
			color.uda.priority.H=rgb050
			color.uda.priority.M=rgb040
			color.uda.priority.L=rgb030
			color.tagged=none
			color.blocked=color249
			color.blocking=rgb240
			color.project.none=
			color.tag.none=
			color.alternate=on color233
			color.tag.next=rgb252
			color.tag.inprogress=rgb252

			####


			report.next.columns=id,project,priority,due,start.active,entry.age,urgency,description.desc,tags
			report.next.labels=ID,Proj,Pri,Due,A,Age,Urg,Description,Tags

			report.ready.columns=id,project,priority,due,start.active,entry.age,urgency,description,tags
			report.ready.labels=ID,Proj,Pri,Due,A,Age,Urg,Description,Tags

			report.triage.description=Personal - To-Do
			report.triage.columns=id,priority,start.active,urgency,due,description.desc,tags
			report.triage.labels=ID,Pri,A,Urg,Due,Description,Tags
			report.triage.filter=( proj: or proj:personal ) ( due.before:tomorrow or due: ) status:pending -WAITING -idea
			report.triage.sort=urgency-

			report.today.description=Tasks for Today
			report.today.columns=id,project,priority,start.active,urgency,due,description.desc,tags
			report.today.labels=ID,Proj,Pri,A,Urg,Due,Description,Tags
			report.today.filter=status:pending -BLOCKED -review and ( ( proj: and ( ( prio:H and due: ) or due.before:tomorrow or +respond or +today or +next or +inprogress or +yesterday) ) or +daytime )
			report.today.sort=urgency-

			report.active.description=Active Tasks
			report.active.columns=id,description.desc,tags
			report.active.labels=ID,Description,Tags
			report.active.filter=status:pending +ACTIVE
			report.active.sort=urgency-


			uda.priority.default=M
			priority.default=M

			urgency.blocking.coefficient=0
			urgency.annotations.coefficient=0
			urgency.user.tag.respond.coefficient=10
			urgency.user.tag.review.coefficient=-5
			urgency.user.tag.inprogress.coefficient=2.5
			urgency.user.tag.today.coefficient=2
			urgency.user.tag.yesterday.coefficient=3
			urgency.user.tag.plane.coefficient=-2

			# relative priority adjustments
			urgency.tags.coefficient=0

			# recurring tasks' due dates aren't that important (especially before they're due)
			urgency.due.coefficient=0.5

			# turn off confirmations
			confirmation = no
			bulk = 5
			recurrence.confirmation = no

			# stop prompting for news
			news.version=2.6.0

			# no ovveride please
			# default: verbose=yes
			verbose=blank,footnote,label,new-id,affected,edit,special,project,sync,unwait
		'';
	};
}