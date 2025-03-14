DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_tables WHERE schemaname = 'public' AND tablename = 'conditions') THEN
        CREATE TABLE IF NOT EXISTS public.conditions (
            id VARCHAR(50) PRIMARY KEY,
            patient_id VARCHAR(50) NOT NULL,
            condition_text text NOT NULL,
            recorded_date date NULL,
            CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES public.patients (id) ON DELETE CASCADE
        );
        CREATE INDEX conditions_condition_text_idx ON public.conditions (condition_text);
        CREATE INDEX conditions_recorded_date_idx ON public.conditions (recorded_date);
    END IF;
END $$;