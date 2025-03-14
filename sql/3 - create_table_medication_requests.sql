DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_tables WHERE schemaname = 'public' AND tablename = 'medication_requests') THEN
       CREATE TABLE IF NOT EXISTS public.medication_requests (
            id VARCHAR(50) PRIMARY KEY,
            patient_id VARCHAR(50) NOT NULL,
            medication_text text NOT NULL,
            authored_on date NULL,
            CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES public.patients (id) ON DELETE CASCADE
        );
        CREATE INDEX medication_requests_medication_text_idx ON public.medication_requests (medication_text);
        CREATE INDEX medication_requests_authored_on_idx ON public.medication_requests (authored_on);
    END IF;
END $$;