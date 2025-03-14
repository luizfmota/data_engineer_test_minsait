DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_tables WHERE schemaname = 'public' AND tablename = 'patients') THEN
        CREATE TABLE public.patients (
            id VARCHAR(50) PRIMARY KEY,
            gender VARCHAR(50) NOT NULL,
            birth_date date NOT NULL
        );
        CREATE INDEX patients_gender_idx ON public.patients (gender);
        CREATE INDEX patients_birth_date_idx ON public.patients (birth_date);
    END IF;
END $$;