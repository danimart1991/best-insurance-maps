
import static org.quartz.JobBuilder.newJob;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import static org.quartz.SimpleScheduleBuilder.simpleSchedule;
import org.quartz.Trigger;
import static org.quartz.TriggerBuilder.newTrigger;
import org.quartz.impl.StdSchedulerFactory;

// @author Henry Joe Wong Urquiza

public class Programacion {
    private Scheduler scheduler=null;
    SchedulerFactory sf ;
    private void crearProgramacio() {

        try {
            sf = new StdSchedulerFactory();
           scheduler = sf.getScheduler();

        } catch (SchedulerException se) {
            se.printStackTrace();
        }
    }
   
    public void iniciarTarea() throws SchedulerException, InterruptedException {
        if (this.scheduler == null) {
            this.crearProgramacio();
        }
        
    JobDetail job = newJob(TareaInvocar.class)
        .withIdentity("job1", "group1")
        .build();

    Trigger trigger = newTrigger()
        .withIdentity("trigger1", "group1")
        .startNow()
        .withSchedule(simpleSchedule()
                .withIntervalInSeconds(40)
                .repeatForever())            
        .build();

    scheduler.scheduleJob(job, trigger);

        scheduler.start();
        Thread.sleep(200L * 1000L);
      //  scheduler.shutdown(true);
    }
}

