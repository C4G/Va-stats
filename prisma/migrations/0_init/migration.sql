-- CreateTable
CREATE TABLE `account` (
    `id` VARCHAR(36) NOT NULL,
    `issuer` VARCHAR(255) NOT NULL,
    `accountId` VARCHAR(255) NOT NULL,
    `providerId` VARCHAR(255) NOT NULL,
    `userId` VARCHAR(36) NOT NULL,
    `accessToken` TEXT NULL,
    `refreshToken` TEXT NULL,
    `idToken` TEXT NULL,
    `accessTokenExpiresAt` DATETIME(3) NULL,
    `refreshTokenExpiresAt` DATETIME(3) NULL,
    `scope` TEXT NULL,
    `password` TEXT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `account_userId_idx`(`userId`),
    UNIQUE INDEX `account_issuer_accountId_unique`(`issuer`, `accountId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `passkey` (
    `id` VARCHAR(36) NOT NULL,
    `name` VARCHAR(255) NULL,
    `publicKey` TEXT NOT NULL,
    `userId` VARCHAR(36) NOT NULL,
    `credentialID` VARCHAR(255) NOT NULL,
    `counter` BIGINT NOT NULL,
    `deviceType` VARCHAR(255) NOT NULL,
    `backedUp` BOOLEAN NOT NULL,
    `transports` VARCHAR(255) NULL,
    `createdAt` DATETIME(3) NULL,
    `aaguid` VARCHAR(255) NULL,

    INDEX `passkey_credentialID_idx`(`credentialID`),
    INDEX `passkey_userId_idx`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `session` (
    `id` VARCHAR(36) NOT NULL,
    `expiresAt` DATETIME(3) NOT NULL,
    `token` VARCHAR(255) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `ipAddress` VARCHAR(255) NULL,
    `userAgent` TEXT NULL,
    `userId` VARCHAR(36) NOT NULL,

    UNIQUE INDEX `session_token_unique`(`token`),
    INDEX `session_userId_idx`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `telecaller_remarks` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `student_id` INTEGER NULL,
    `user_id` INTEGER NOT NULL,
    `remark` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `idx_created_at`(`created_at`),
    INDEX `idx_student_id`(`student_id`),
    INDEX `idx_user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user` (
    `id` VARCHAR(36) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `emailVerified` BOOLEAN NOT NULL DEFAULT false,
    `image` TEXT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `user_email_unique`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `va_app_settings` (
    `setting_key` VARCHAR(100) NOT NULL,
    `setting_value` LONGTEXT NOT NULL,
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`setting_key`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `va_assignments` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `batch_id` INTEGER NOT NULL,
    `assignment_name` VARCHAR(80) NOT NULL,
    `assignment_type` TINYINT NOT NULL,
    `weight` TINYINT NOT NULL,
    `student_url` VARCHAR(200) NOT NULL,

    INDEX `fk_va_assignments_batch_id`(`batch_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `va_attendance` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `batch_id` INTEGER NOT NULL,
    `student_id` INTEGER NULL,
    `date` DATE NOT NULL,
    `is_present` TINYINT NOT NULL DEFAULT 100,

    INDEX `fk_va_attendance_batch_id`(`batch_id`),
    INDEX `fk_va_attendance_student_id`(`student_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `va_audit_logs` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `action_type` VARCHAR(255) NOT NULL,
    `performed_by` VARCHAR(255) NOT NULL,
    `performed_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `details` JSON NULL,
    `resource_type` VARCHAR(255) NULL,
    `resource_id` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `va_dropdown_values` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `dropdown_key` VARCHAR(100) NOT NULL,
    `value` VARCHAR(255) NOT NULL,
    `label` VARCHAR(255) NOT NULL,
    `sort_order` INTEGER NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `uniq_dropdown_value`(`dropdown_key`, `value`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `va_fees` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `batch_id` INTEGER NOT NULL,
    `student_id` INTEGER NULL,
    `fee_paid` VARCHAR(35) NOT NULL DEFAULT 'NA',
    `amount_1` INTEGER NOT NULL,
    `amount_2` INTEGER NOT NULL,
    `amount_3` INTEGER NOT NULL,
    `nature_of_fee` VARCHAR(35) NOT NULL,

    INDEX `fk_va_fees_batch_id`(`batch_id`),
    INDEX `fk_va_fees_student_id`(`student_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `va_grades` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `student_id` INTEGER NULL,
    `batch_id` INTEGER NOT NULL,
    `assignment_name` VARCHAR(50) NOT NULL,
    `assignment_type` VARCHAR(35) NOT NULL,
    `assignment_weight` INTEGER NOT NULL,
    `grade` INTEGER NOT NULL,
    `max_marks` INTEGER NOT NULL,

    INDEX `fk_va_grades_batch_id`(`batch_id`),
    INDEX `fk_va_grades_student_id`(`student_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `va_remarks` (
    `id` SMALLINT NOT NULL AUTO_INCREMENT,
    `vastudent_to_batch_id` SMALLINT NOT NULL,
    `remarks` VARCHAR(250) NOT NULL,
    `user_id` INTEGER NOT NULL,

    INDEX `user_id`(`user_id`),
    INDEX `vastudent_to_batch_id`(`vastudent_to_batch_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vabatches` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `coursename` VARCHAR(50) NOT NULL,
    `batch` VARCHAR(15) NOT NULL,
    `coursestart` VARCHAR(50) NOT NULL,
    `courseend` VARCHAR(50) NOT NULL,
    `coursedays` VARCHAR(20) NOT NULL,
    `coursetimes` VARCHAR(50) NOT NULL,
    `instructor` VARCHAR(50) NOT NULL,
    `PM` VARCHAR(50) NOT NULL,
    `TA` VARCHAR(50) NOT NULL,
    `dataentry` VARCHAR(50) NOT NULL,
    `cost` INTEGER NULL,
    `currency` ENUM('INR', 'USD', 'NA') NULL,
    `strength` INTEGER NOT NULL,
    `trainingmode` ENUM('VIRTUAL', 'IN-PERSON', 'SELF-PACED') NOT NULL,
    `status` ENUM('UNSTARTED', 'ONGOING', 'COMPLETE') NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vacourses` (
    `id` SMALLINT NOT NULL AUTO_INCREMENT,
    `course` TEXT NOT NULL,
    `description` TEXT NULL,
    `duration` TEXT NOT NULL,
    `duration_type` ENUM('Weeks', 'Months', 'Days') NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vastudent_to_batch` (
    `id` SMALLINT NOT NULL AUTO_INCREMENT,
    `student_id` INTEGER NULL,
    `batch_id` INTEGER NULL,
    `grade` VARCHAR(55) NULL,
    `attendance` VARCHAR(55) NULL,
    `completion_status` VARCHAR(255) NULL,
    `certification_eligibility` VARCHAR(255) NULL,
    `reason_for_status` VARCHAR(255) NULL,
    `next_program` VARCHAR(255) NULL,
    `counseling_status` ENUM('Yes', 'No') NULL DEFAULT 'No',
    `placement_status` ENUM('No Change', 'During Training', 'After Training', 'Supported by Vision Aid') NULL DEFAULT 'No Change',
    `placement_remarks` TEXT NULL,

    INDEX `fk_vastudent_to_batch_batch_id`(`batch_id`),
    INDEX `fk_vastudent_to_batch_student_id`(`student_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vastudents` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `Quarter` INTEGER NULL,
    `SNo` INTEGER NULL,
    `Batch_ID` VARCHAR(55) NULL,
    `Program_Name` VARCHAR(55) NULL,
    `Trainee_ID` VARCHAR(55) NULL,
    `name` VARCHAR(35) NULL,
    `edu_qualifications` VARCHAR(300) NULL,
    `phone_number` BIGINT NULL,
    `alt_ph_num` BIGINT NULL,
    `CityDistrict_State` VARCHAR(55) NULL,
    `email` VARCHAR(35) NULL,
    `gender` VARCHAR(30) NULL,
    `age` DATE NULL,
    `visual_acuity` VARCHAR(50) NULL,
    `percent_loss` INTEGER NULL,
    `employment_status` VARCHAR(50) NULL,
    `Designation` VARCHAR(55) NULL,
    `Languages_Known` VARCHAR(55) NULL,
    `Program_ManagerCoordinator` VARCHAR(55) NULL,
    `country` VARCHAR(55) NULL,
    `state` VARCHAR(50) NULL,
    `city` VARCHAR(50) NULL,
    `disability` VARCHAR(50) NOT NULL,
    `edu_details` VARCHAR(50) NOT NULL,
    `objectives` VARCHAR(300) NULL,
    `first_choice` VARCHAR(50) NULL,
    `second_choice` VARCHAR(50) NULL,
    `third_choice` VARCHAR(50) NULL,
    `first_recommendation` VARCHAR(55) NULL,
    `second_recommendation` VARCHAR(55) NULL,
    `third_recommendation` VARCHAR(55) NULL,
    `impairment_history` VARCHAR(300) NULL,
    `source` VARCHAR(80) NULL,
    `registration_date` DATE NULL,
    `id_proof` ENUM('Yes', 'No') NOT NULL DEFAULT 'Yes',
    `disability_cert` ENUM('Yes', 'No') NOT NULL DEFAULT 'Yes',
    `photo` ENUM('Yes', 'No') NOT NULL DEFAULT 'Yes',
    `bank_details` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `completion_status` TEXT NULL,
    `reason_for_status` VARCHAR(150) NULL,
    `certification_eligibility` TEXT NULL,
    `risk_factor` ENUM('', 'Medium', 'High') NULL,
    `remarks` VARCHAR(250) NULL,
    `commenter` VARCHAR(55) NULL,
    `last_edited` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `enrollment_status` ENUM('ENROLLED', 'NO_RESPONSE_SW_OFF', 'FOLLOW_UP', 'WRONG_NUMBER', 'DROPOUT', 'PROSPECT', 'COUNSELLED_BY_PM', 'AVAILABLE') NULL,

    UNIQUE INDEX `id`(`id`),
    UNIQUE INDEX `unique_gender_phone_age`(`gender`, `phone_number`, `age`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vausers` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `employeeId` VARCHAR(50) NULL,
    `email` VARCHAR(50) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `designation` VARCHAR(35) NOT NULL,
    `joindate` DATE NULL,
    `mobilenumber` VARCHAR(20) NULL,
    `workbase` VARCHAR(35) NOT NULL,
    `supervisor` VARCHAR(35) NOT NULL,
    `natureofjob` VARCHAR(35) NOT NULL,
    `visualacuity` VARCHAR(50) NULL,
    `role` VARCHAR(35) NOT NULL,
    `isactive` ENUM('A', 'I') NOT NULL DEFAULT 'A',
    `action` VARCHAR(35) NOT NULL,
    `gender` VARCHAR(20) NULL,
    `date_of_birth` DATE NULL,
    `contract_duration_months` INTEGER NULL,
    `program_project` VARCHAR(255) NULL,
    `lastlogin` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `trainingprogram1` VARCHAR(255) NULL DEFAULT '',
    `trainingprogram2` VARCHAR(255) NULL DEFAULT '',
    `trainingprogram3` VARCHAR(255) NULL DEFAULT '',

    UNIQUE INDEX `employee_number`(`employeeId`),
    UNIQUE INDEX `email`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `verification` (
    `id` VARCHAR(36) NOT NULL,
    `identifier` VARCHAR(255) NOT NULL,
    `value` TEXT NOT NULL,
    `expiresAt` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `verification_identifier_idx`(`identifier`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `account` ADD CONSTRAINT `account_userId_fk` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `passkey` ADD CONSTRAINT `passkey_userId_fk` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `session` ADD CONSTRAINT `session_userId_fk` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `telecaller_remarks` ADD CONSTRAINT `fk_telecaller_remarks_student_id` FOREIGN KEY (`student_id`) REFERENCES `vastudents`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `telecaller_remarks` ADD CONSTRAINT `fk_telecaller_remarks_user_id` FOREIGN KEY (`user_id`) REFERENCES `vausers`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `va_assignments` ADD CONSTRAINT `fk_va_assignments_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `vabatches`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `va_attendance` ADD CONSTRAINT `fk_va_attendance_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `vabatches`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `va_attendance` ADD CONSTRAINT `fk_va_attendance_student_id` FOREIGN KEY (`student_id`) REFERENCES `vastudents`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `va_fees` ADD CONSTRAINT `fk_va_fees_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `vabatches`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `va_fees` ADD CONSTRAINT `fk_va_fees_student_id` FOREIGN KEY (`student_id`) REFERENCES `vastudents`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `va_grades` ADD CONSTRAINT `fk_va_grades_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `vabatches`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `va_grades` ADD CONSTRAINT `fk_va_grades_student_id` FOREIGN KEY (`student_id`) REFERENCES `vastudents`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `va_remarks` ADD CONSTRAINT `fk_va_remarks_vastudent_to_batch_id` FOREIGN KEY (`vastudent_to_batch_id`) REFERENCES `vastudent_to_batch`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `va_remarks` ADD CONSTRAINT `va_remarks_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `vausers`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vastudent_to_batch` ADD CONSTRAINT `fk_vastudent_to_batch_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `vabatches`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vastudent_to_batch` ADD CONSTRAINT `fk_vastudent_to_batch_student_id` FOREIGN KEY (`student_id`) REFERENCES `vastudents`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
